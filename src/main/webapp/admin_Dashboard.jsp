<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"admin".equals(role)) {
        response.sendRedirect("home");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookNook - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f0f2f5; }
        .admin-banner { 
            background: #212529; 
            color: white; 
            padding: 3rem 0; 
            margin-bottom: 2rem;
            border-bottom: 5px solid #0d6efd;
        }
        .admin-card {
            transition: transform 0.2s, box-shadow 0.2s;
            border: none;
            border-radius: 12px;
        }
        .admin-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .icon-circle {
            width: 60px;
            height: 60px;
            background: #e9ecef;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <%@ include file="top_info.jsp" %>
    <%@ include file="navbar.jsp" %>

    <main class="flex-grow-1">
        <div class="admin-banner text-center shadow">
            <div class="container">
                <h1 class="display-4 fw-bold">Management Console</h1>
                <p class="lead">Logged in as: <span class="badge bg-primary px-3 py-2"><%= username %></span></p>
            </div>
        </div>

        <div class="container pb-5">
            <div class="row g-4 justify-content-center">
                
                <div class="col-md-5 col-lg-4">
                    <div class="card admin-card h-100 p-3 text-center shadow-sm">
                        <div class="card-body d-flex flex-column">
                            <div class="icon-circle mx-auto text-primary">
                                <i class="fas fa-book"></i>
                            </div>
                            <h4 class="card-title fw-bold">Inventory</h4>
                            <p class="text-muted">Add, edit, or remove books from the store catalog.</p>
                            <a href="adminBook" class="btn btn-primary mt-auto py-2 fw-bold">Manage Books</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-5 col-lg-4">
                    <div class="card admin-card h-100 p-3 text-center shadow-sm">
                        <div class="card-body d-flex flex-column">
                            <div class="icon-circle mx-auto text-success">
                                <i class="fas fa-users-cog"></i>
                            </div>
                            <h4 class="card-title fw-bold">User Accounts</h4>
                            <p class="text-muted">View registered customers and manage permissions.</p>
                            <a href="adminUser" class="btn btn-success mt-auto py-2 fw-bold">Manage Users</a>
                        </div>
                    </div>
                </div>

            </div>

            <div class="row mt-5">
                <div class="col-12 text-center">
                    <div class="alert alert-info d-inline-block px-5 border-0 shadow-sm">
                        <strong>System Status:</strong> All services operational.
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>