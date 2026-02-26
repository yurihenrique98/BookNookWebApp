<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, models.User" %>

<%
    // Allow access only for admin users
    String role = (String) session.getAttribute("role");
    if (!"admin".equals(role)) {
        response.sendRedirect("home.jsp");
        return;
    }

    // Retrieve user list from request
    List<User> users = (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - User Management</title>
</head>
<body>
    <h2>👥 Admin - Manage Users</h2>

    <!-- Search form -->
    <form method="get" action="adminUser">
        Search by username: 
        <input type="text" name="filter" />
        <input type="submit" value="Search">
    </form>

    <!-- User table -->
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Username</th>
            <th>Role</th>
            <th>Email</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>

        <% if (users != null) {
            for (User user : users) { %>
                <tr>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getRole() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.isActive() ? "Active" : "Deactivated" %></td>
                    <td>
                        <% if (user.isActive()) { %>
                            <!-- Deactivate form -->
                            <form method="post" action="adminUser" style="display:inline">
                                <input type="hidden" name="action" value="deactivate">
                                <input type="hidden" name="id" value="<%= user.getId() %>">
                                <input type="submit" value="Deactivate" onclick="return confirm('Deactivate this user?')">
                            </form>
                        <% } else { %>
                            <em>Deactivated</em>
                        <% } %>
                    </td>
                </tr>
        <%  }} %>
    </table>

    <p><a href="home.jsp"> Back to Home</a></p>
</body>
</html>