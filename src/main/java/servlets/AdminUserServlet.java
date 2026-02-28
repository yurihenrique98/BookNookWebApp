package servlets;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import Repositories.UserRepository;
import models.User;

public class AdminUserServlet extends HttpServlet {

    private UserRepository repo = new UserRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (role == null || !role.equalsIgnoreCase("admin")) {
            response.sendRedirect("login.jsp?error=unauthorized");
            return;
        }

        String filter = request.getParameter("filter");
        if (filter == null) {
            filter = "";
        }

        List<User> users = repo.getAllUsers(filter);

        request.setAttribute("users", users);
        request.setAttribute("currentFilter", filter); 
        request.getRequestDispatcher("admin_users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (!"admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN); 
            return;
        }

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                
                if ("deactivate".equals(action)) {
                    repo.deactivateUser(id); 
                } else if ("activate".equals(action)) {
                    repo.activateUser(id); 
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid User ID received in AdminUserServlet: " + idStr);
            }
        }

        response.sendRedirect("adminUser");
    }
}