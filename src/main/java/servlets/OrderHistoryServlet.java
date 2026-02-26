package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DBUtil;

/**
 * This servlet handles displaying the order history for a logged-in user.
 * It retrieves all past orders from the database and forwards them to the order history JSP.
 */
public class OrderHistoryServlet extends HttpServlet {

    /**
     * Handles GET requests to display a user's order history.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the logged-in username from the session
        String username = (String) request.getSession().getAttribute("username");

        // Redirect to login page if user is not logged in
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Map<String, Object>> orders = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            // Query to get all orders for the current user
            String sql = "SELECT * FROM orders WHERE username = ? ORDER BY order_date DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            // Iterate through the result set and add each order to the list
            while (rs.next()) {
                Map<String, Object> order = new HashMap<>();
                order.put("id", rs.getInt("id"));
                order.put("total", rs.getDouble("total"));
                order.put("date", rs.getString("order_date"));
                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Log SQL errors
        }

        // Set the orders list as a request attribute for the JSP
        request.setAttribute("orders", orders);

        // Forward the request to the order history JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("order_history.jsp");
        dispatcher.forward(request, response);
    }
}