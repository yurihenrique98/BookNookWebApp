package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DBUtil;

/**
 * Servlet that handles the checkout process.
 * Validates the cart and user session, processes the order,
 * updates stock, and stores order details in the database.
 */
public class CheckoutServlet extends HttpServlet {

    /**
     * Handles POST request to submit a user's order.
     * Performs transaction-safe insert of the order and items.
     */
    @Override
    @SuppressWarnings("unchecked") // Suppresses warning for casting session attribute
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        // Validate session and cart
        if (cart == null || cart.isEmpty() || username == null) {
            response.sendRedirect("cart.jsp?error=empty");
            return;
        }

        // Calculate total amount
        double total = 0;
        for (Map<String, Object> item : cart) {
            int quantity = (int) item.get("quantity");
            double price = (double) item.get("price");
            total += quantity * price;
        }

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false); // Begin transaction

            // Insert order into 'orders' table
            String orderSql = "INSERT INTO orders (username, total) VALUES (?, ?)";
            PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setString(1, username);
            orderStmt.setDouble(2, total);
            orderStmt.executeUpdate();

            // Get generated order ID
            ResultSet generatedKeys = orderStmt.getGeneratedKeys();
            if (!generatedKeys.next()) throw new SQLException("Failed to retrieve order ID.");
            int orderId = generatedKeys.getInt(1);

            // Prepare statements for order items and stock update
            String itemSql = "INSERT INTO order_items (order_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
            String stockSql = "UPDATE books SET stock = stock - ? WHERE id = ?";
            PreparedStatement itemStmt = conn.prepareStatement(itemSql);
            PreparedStatement stockStmt = conn.prepareStatement(stockSql);

            // Insert items and update stock
            for (Map<String, Object> item : cart) {
                int bookId = (int) item.get("bookId");
                int quantity = (int) item.get("quantity");
                double price = (double) item.get("price");

                // Add order item
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, bookId);
                itemStmt.setInt(3, quantity);
                itemStmt.setDouble(4, price);
                itemStmt.addBatch();

                // Update book stock
                stockStmt.setInt(1, quantity);
                stockStmt.setInt(2, bookId);
                stockStmt.addBatch();
            }

            // Execute batch operations
            itemStmt.executeBatch();
            stockStmt.executeBatch();

            // Commit transaction
            conn.commit();

            // Clear cart and redirect to success page
            session.removeAttribute("cart");
            response.sendRedirect("order_success.jsp");

        } catch (SQLException e) {
            // Consider using a logger in production
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=checkout");
        }
    }
}