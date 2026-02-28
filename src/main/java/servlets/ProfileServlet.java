package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import dao.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Map<String, String> profile = new HashMap<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT email, phone, address FROM users WHERE username = ?")) {
            
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    profile.put("email", rs.getString("email"));
                    profile.put("phone", rs.getString("phone") != null ? rs.getString("phone") : "");
                    profile.put("address", rs.getString("address") != null ? rs.getString("address") : "");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("profile", profile);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String newPassword = request.getParameter("password");

        try (Connection conn = DBUtil.getConnection()) {
            String sql;
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                sql = "UPDATE users SET email=?, phone=?, address=?, password=? WHERE username=?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, email);
                    stmt.setString(2, phone);
                    stmt.setString(3, address);
                    stmt.setString(4, newPassword);
                    stmt.setString(5, username);
                    stmt.executeUpdate();
                }
            } else {
                sql = "UPDATE users SET email=?, phone=?, address=? WHERE username=?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, email);
                    stmt.setString(2, phone);
                    stmt.setString(3, address);
                    stmt.setString(4, username);
                    stmt.executeUpdate();
                }
            }

            response.sendRedirect("profile?success=1");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("profile?error=1");
        }
    }
}