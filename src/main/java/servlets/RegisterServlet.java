package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DBUtil;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email    = request.getParameter("email");

        System.out.println("Attempting to register user: " + username);

        try (Connection conn = DBUtil.getConnection()) {
            System.out.println("Connected to DB!");

            // Check if username exists
            String checkSql = "SELECT * FROM users WHERE username = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, username);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                System.out.println("Username already exists.");
                request.setAttribute("error", "Username already exists.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Insert new user
            String insertSql = "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, 'user')";
            PreparedStatement insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setString(1, username);
            insertStmt.setString(2, password);
            insertStmt.setString(3, email);
            int result = insertStmt.executeUpdate();

            System.out.println("User registration insert result: " + result);

            if (result > 0) {
                // Redirect with ?success=true so login.jsp shows green message
                response.sendRedirect("login.jsp?success=true");
            } else {
                request.setAttribute("error", "Registration failed.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
            request.setAttribute("error", "A database error occurred.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}