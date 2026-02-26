package servlets;

import dao.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

/**
 * Servlet that handles retrieving order item details based on the given order ID.
 * Displays the list of books included in the selected order.
 */
public class OrderDetailsServlet extends HttpServlet {

    /**
     * Handles GET requests to retrieve details of a specific order.
     * The order ID is passed as a request parameter.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Extract order ID from the request parameter
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        List<Map<String, Object>> items = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            // SQL query to retrieve order item details joined with book titles
            String sql = "SELECT oi.quantity, oi.price, b.title FROM order_items oi " +
                         "JOIN books b ON oi.book_id = b.id WHERE oi.order_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            // Store results into a list of maps for the JSP view
            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("title", rs.getString("title"));
                item.put("price", rs.getDouble("price"));
                item.put("quantity", rs.getInt("quantity"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log error to server
        }

        // Pass order items to the JSP page
        request.setAttribute("items", items);
        RequestDispatcher dispatcher = request.getRequestDispatcher("order_details.jsp");
        dispatcher.forward(request, response);
    }
}