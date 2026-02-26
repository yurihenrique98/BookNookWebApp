package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DBUtil;

/**
 * Handles viewing and updating the user profile.
 */
public class ProfileServlet extends HttpServlet {

    /**
     * Handles GET requests to display the current user's profile information.
     */
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

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT email, phone, address FROM users WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                profile.put("email", rs.getString("email"));
                profile.put("phone", rs.getString("phone"));
                profile.put("address", rs.getString("address"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("profile", profile);
        RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles POST requests to update the user's profile information.
     */
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
            PreparedStatement stmt;

            if (newPassword != null && !newPassword.trim().isEmpty()) {
                sql = "UPDATE users SET email=?, phone=?, address=?, password=? WHERE username=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, email);
                stmt.setString(2, phone);
                stmt.setString(3, address);
                stmt.setString(4, newPassword);
                stmt.setString(5, username);
            } else {
                sql = "UPDATE users SET email=?, phone=?, address=? WHERE username=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, email);
                stmt.setString(2, phone);
                stmt.setString(3, address);
                stmt.setString(4, username);
            }

            stmt.executeUpdate();
            response.sendRedirect("profile.jsp?success=1");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=1");
        }
    }
}