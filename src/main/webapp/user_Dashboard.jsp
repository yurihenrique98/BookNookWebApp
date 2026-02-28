<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    if (username == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - BookNook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f0f2f5; }
        .dashboard-banner { 
            background: linear-gradient(45deg, #212529, #343a40); 
            color: white; 
            padding: 4rem 0; 
            margin-bottom: 2rem; 
            border-bottom: 4px solid #0d6efd;
        }
        .action-card { 
            border: none; 
            border-radius: 15px; 
            transition: all 0.3s ease; 
            text-decoration: none !important; 
            color: inherit; 
            height: 100%; 
        }
        .action-card:hover { 
            transform: translateY(-10px); 
            box-shadow: 0 15px 30px rgba(0,0,0,0.1); 
            background-color: #ffffff;
        }
        .icon-box { 
            width: 70px; 
            height: 70px; 
            border-radius: 50%; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 2rem; 
            margin: 0 auto 1.5rem; 
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <%@ include file="top_info.jsp" %>
    <%@ include file="navbar.jsp" %>

    <div class="dashboard-banner text-center shadow-sm">
        <div class="container">
            <div class="mb-3">
                <img src="https://ui-avatars.com/api/?name=<%= username %>&background=0d6efd&color=fff&size=80" 
                     class="rounded-circle border border-3 border-white shadow" alt="User">
            </div>
            <h1 class="display-5 fw-bold">Welcome back, <%= username %>!</h1>
            <p class="lead opacity-75">Manage your account and explore your next favorite read.</p>
        </div>
    </div>

    <main class="container mb-5 flex-grow-1">
        <div class="row g-4 justify-content-center">
            
            <div class="col-md-4">
                <a href="home" class="card action-card shadow-sm p-4 text-center">
                    <div class="icon-box bg-primary-subtle text-primary">
                        <i class="fas fa-book-open"></i>
                    </div>
                    <h4 class="fw-bold">Browse Books</h4>
                    <p class="text-muted small">Explore our full catalog</p>
                </a>
            </div>

            <div class="col-md-4">
                <a href="cart.jsp" class="card action-card shadow-sm p-4 text-center">
                    <div class="icon-box bg-warning-subtle text-warning">
                        <i class="fas fa-shopping-basket"></i>
                    </div>
                    <h4 class="fw-bold">My Shopping Cart</h4>
                    <p class="text-muted small">Items waiting for checkout</p>
                </a>
            </div>

            <div class="col-md-4">
                <a href="orderHistory" class="card action-card shadow-sm p-4 text-center">
                    <div class="icon-box bg-success-subtle text-success">
                        <i class="fas fa-history"></i>
                    </div>
                    <h4 class="fw-bold">Order History</h4>
                    <p class="text-muted small">Track and view past orders</p>
                </a>
            </div>

            <div class="col-md-4">
                <a href="profile" class="card action-card shadow-sm p-4 text-center">
                    <div class="icon-box bg-info-subtle text-info">
                        <i class="fas fa-user-cog"></i>
                    </div>
                    <h4 class="fw-bold">Profile Settings</h4>
                    <p class="text-muted small">Update your personal info</p>
                </a>
            </div>

        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>