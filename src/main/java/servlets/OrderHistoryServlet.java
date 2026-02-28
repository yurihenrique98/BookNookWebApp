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

import dao.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Map<String, Object>> orders = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            String sql;
            PreparedStatement stmt;

            if ("admin".equalsIgnoreCase(role)) {
                sql = "SELECT id, total, date, username FROM orders ORDER BY date DESC";
                stmt = conn.prepareStatement(sql);
            } else {
                sql = "SELECT id, total, date FROM orders WHERE username = ? ORDER BY date DESC";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> order = new HashMap<>();
                    order.put("id", rs.getInt("id"));
                    order.put("total", rs.getDouble("total"));
                    order.put("date", rs.getString("date")); 

                    if ("admin".equalsIgnoreCase(role)) {
                        order.put("customer", rs.getString("username"));
                    }
                    
                    orders.add(order);
                }
            }
            stmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not retrieve order history.");
        }

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("order_history.jsp").forward(request, response);
    }
}