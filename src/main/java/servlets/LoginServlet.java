package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dao.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT role, active FROM users WHERE username = ? AND password = ?")) {
            
            stmt.setString(1, username);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    boolean isActive = rs.getBoolean("active");
                    
                    if (!isActive) {
                        response.sendRedirect("login.jsp?error=deactivated");
                        return;
                    }

                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    String role = rs.getString("role");
                    session.setAttribute("role", role);

                    if ("admin".equalsIgnoreCase(role)) {
                        response.sendRedirect("adminBook"); 
                    } else {
                        response.sendRedirect("user_Dashboard.jsp");
                    }

                } else {
                    response.sendRedirect("login.jsp?error=invalid");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=database");
        }
    }
}