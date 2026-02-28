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

public class OrderDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String sessionUser = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        if (sessionUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect("orderHistory");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);
        List<Map<String, Object>> items = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            
            if (!"admin".equalsIgnoreCase(role)) {
                String verifySql = "SELECT username FROM orders WHERE id = ?";
                try (PreparedStatement vStmt = conn.prepareStatement(verifySql)) {
                    vStmt.setInt(1, orderId);
                    ResultSet vRs = vStmt.executeQuery();
                    if (vRs.next()) {
                        String orderOwner = vRs.getString("username");
                        if (!sessionUser.equals(orderOwner)) {
                            response.sendRedirect("orderHistory?error=unauthorized");
                            return;
                        }
                    }
                }
            }

            String sql = "SELECT oi.quantity, oi.price, b.title FROM order_items oi " +
                         "JOIN books b ON oi.book_id = b.id WHERE oi.order_id = ?";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, orderId);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> item = new HashMap<>();
                        item.put("title", rs.getString("title"));
                        item.put("price", rs.getDouble("price"));
                        item.put("quantity", rs.getInt("quantity"));
                        items.add(item);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("items", items);
        request.setAttribute("orderId", orderId); 
        request.getRequestDispatcher("order_details.jsp").forward(request, response);
    }
}