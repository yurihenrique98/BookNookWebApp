package servlets;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets; 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

import dao.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CheckoutServlet extends HttpServlet {

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        // 1. Basic Validation
        if (cart == null || cart.isEmpty() || username == null) {
            response.sendRedirect("cart.jsp?error=empty");
            return;
        }

        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); 

            // 2. Calculate Total Defensively (using Number to prevent ClassCastException)
            double total = 0;
            for (Map<String, Object> item : cart) {
                int qty = ((Number) item.get("quantity")).intValue();
                double price = ((Number) item.get("price")).doubleValue();
                total += qty * price;
            }

            // 3. Stock Check
            String checkStockSql = "SELECT stock, title FROM books WHERE id = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkStockSql)) {
                for (Map<String, Object> item : cart) {
                    checkStmt.setInt(1, ((Number) item.get("bookId")).intValue());
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (rs.next()) {
                            int currentStock = rs.getInt("stock");
                            int requestedQty = ((Number) item.get("quantity")).intValue();
                            if (currentStock < requestedQty) {
                                conn.rollback(); 
                                String title = URLEncoder.encode(rs.getString("title"), StandardCharsets.UTF_8.toString());
                                response.sendRedirect("cart.jsp?error=outOfStock&book=" + title);
                                return;
                            }
                        }
                    }
                }
            }

            // 4. Create Main Order Record
            String orderSql = "INSERT INTO orders (username, total, date) VALUES (?, ?, NOW())";
            int orderId;
            try (PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                orderStmt.setString(1, username);
                orderStmt.setDouble(2, total);
                orderStmt.executeUpdate();
                try (ResultSet gk = orderStmt.getGeneratedKeys()) {
                    if (!gk.next()) throw new SQLException("Order ID generation failed");
                    orderId = gk.getInt(1);
                }
            }

            // 5. Insert Items & Update Stock (Batch Processing)
            String itemSql = "INSERT INTO order_items (order_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
            String stockSql = "UPDATE books SET stock = stock - ? WHERE id = ?";
            
            try (PreparedStatement itemStmt = conn.prepareStatement(itemSql);
                 PreparedStatement stockStmt = conn.prepareStatement(stockSql)) {
                
                for (Map<String, Object> item : cart) {
                    int bId = ((Number) item.get("bookId")).intValue();
                    int qty = ((Number) item.get("quantity")).intValue();
                    double prc = ((Number) item.get("price")).doubleValue();
                    
                    itemStmt.setInt(1, orderId);
                    itemStmt.setInt(2, bId);
                    itemStmt.setInt(3, qty);
                    itemStmt.setDouble(4, prc);
                    itemStmt.addBatch();

                    stockStmt.setInt(1, qty);
                    stockStmt.setInt(2, bId);
                    stockStmt.addBatch();
                }
                itemStmt.executeBatch();
                stockStmt.executeBatch();
            }

            // 6. Commit and Cleanup
            conn.commit(); 
            session.removeAttribute("cart");
            session.setAttribute("cartCount", 0); // Reset navbar badge
            
            response.sendRedirect("order_success.jsp");

        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=server");
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}