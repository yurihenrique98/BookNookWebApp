package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Repositories.UserRepository;
import models.User;

/**
 * Servlet for managing users through the admin interface.
 * Handles listing users and deactivating accounts.
 */
public class AdminUserServlet extends HttpServlet {

    // Repository to handle user-related DB operations
    UserRepository repo = new UserRepository();

    /**
     * Handles GET requests to retrieve and display filtered user list.
     * Sends data to 'admin_users.jsp'.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filter = request.getParameter("filter");
        if (filter == null) filter = "";

        // Fetch filtered user list
        List<User> users = repo.getAllUsers(filter);

        // Attach users to request scope and forward to JSP
        request.setAttribute("users", users);
        request.getRequestDispatcher("admin_users.jsp").forward(request, response);
    }

    /**
     * Handles POST requests to perform user actions 
     * Redirects back to the admin user management page.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("deactivate".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            repo.deactivateUser(id); // Set user as inactive
        }

        // Refresh page after action
        response.sendRedirect("adminUser");
    }
}