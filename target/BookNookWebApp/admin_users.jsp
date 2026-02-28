<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, models.User" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    if (!"admin".equals(role)) {
        response.sendRedirect("home");
        return;
    }

    List<User> users = (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - BookNook Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .user-table-container { background: white; border-radius: 12px; padding: 25px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .search-box { max-width: 400px; }
        .role-badge { font-size: 0.8rem; letter-spacing: 0.5px; }
        .table thead th { border-top: none; background-color: #fcfcfc; color: #6c757d; font-weight: 600; }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <%@ include file="top_info.jsp" %>
    <%@ include file="navbar.jsp" %>

    <main class="container py-5 flex-grow-1">
        <div class="row mb-4 align-items-center">
            <div class="col-md-6">
                <h2 class="fw-bold mb-0">User Accounts</h2>
                <p class="text-muted">Monitor and manage access for all registered members.</p>
            </div>
            
            <div class="col-md-6 text-md-end">
                <form method="get" action="adminUser" class="d-inline-block search-box w-100">
                    <div class="input-group shadow-sm">
                        <input type="text" name="filter" class="form-control" placeholder="Search by username..." value="<%= request.getAttribute("currentFilter") != null ? request.getAttribute("currentFilter") : "" %>" />
                        <button class="btn btn-primary fw-bold" type="submit"><i class="fas fa-search"></i> Search</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="user-table-container">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th>User Details</th>
                            <th>Role</th>
                            <th>Email</th>
                            <th>Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (users != null && !users.isEmpty()) {
                            for (User user : users) { %>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>&size=32&background=random" class="rounded-circle me-2 shadow-sm" alt="avatar">
                                            <span class="fw-bold text-dark"><%= user.getUsername() %></span>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge rounded-pill role-badge <%= "admin".equals(user.getRole()) ? "bg-info text-dark" : "bg-light text-dark border" %>">
                                            <%= user.getRole().toUpperCase() %>
                                        </span>
                                    </td>
                                    <td class="text-muted small"><%= user.getEmail() %></td>
                                    <td>
                                        <% if (user.isActive()) { %>
                                            <span class="badge bg-success-subtle text-success border border-success-subtle px-3">Active</span>
                                        <% } else { %>
                                            <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3">Deactivated</span>
                                        <% } %>
                                    </td>
                                    <td class="text-end">
                                        <form method="post" action="adminUser" style="display:inline">
                                            <input type="hidden" name="id" value="<%= user.getId() %>">
                                            <% if (user.isActive()) { %>
                                                <input type="hidden" name="action" value="deactivate">
                                                <button type="submit" class="btn btn-sm btn-outline-danger shadow-sm rounded-pill px-3" 
                                                        onclick="return confirm('Deactivate <%= user.getUsername() %>?')">
                                                    <i class="fas fa-user-slash"></i> Deactivate
                                                </button>
                                            <% } else { %>
                                                <input type="hidden" name="action" value="activate">
                                                <button type="submit" class="btn btn-sm btn-outline-success shadow-sm rounded-pill px-3">
                                                    <i class="fas fa-user-check"></i> Activate
                                                </button>
                                            <% } %>
                                        </form>
                                    </td>
                                </tr>
                        <%  } } else { %>
                            <tr>
                                <td colspan="5" class="text-center py-5">
                                    <div class="display-6 mb-2">👤</div>
                                    <p class="text-muted mb-0">No users found matching your search.</p>
                                    <a href="adminUser" class="btn btn-link btn-sm mt-2 text-decoration-none">Clear Search</a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="mt-4">
            <a href="home" class="text-decoration-none text-muted small"><i class="fas fa-arrow-left"></i> Back to Storefront</a>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>