<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookNook - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .login-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .login-card {
            background: white;
            padding: 2.5rem;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
        }
        .brand-logo {
            font-size: 2.5rem;
            text-align: center;
            margin-bottom: 1.5rem;
            display: block;
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <%@ include file="top_info.jsp" %>

    <div class="login-wrapper">
        <div class="login-card">
            <span class="brand-logo">📚</span>
            <h2 class="text-center fw-bold mb-4">Welcome to BookNook</h2>

            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger py-2 text-center" role="alert">
                    Invalid username or password.
                </div>
            <% } else if (request.getParameter("success") != null) { %>
                <div class="alert alert-success py-2 text-center" role="alert">
                    Registration successful!
                </div>
            <% } else if (request.getParameter("logout") != null) { %>
                <div class="alert alert-info py-2 text-center" role="alert">
                    Logged out successfully.
                </div>
            <% } %>

            <form method="post" action="${pageContext.request.contextPath}/login">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Username</label>
                    <input type="text" name="username" class="form-control form-control-lg" placeholder="Enter username" required>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-semibold">Password</label>
                    <input type="password" name="password" class="form-control form-control-lg" placeholder="••••••••" required>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg fw-bold">Login</button>
                </div>
            </form>

            <div class="text-center mt-4">
                <p class="text-muted mb-0">Don't have an account?</p>
                <a href="${pageContext.request.contextPath}/register.jsp" class="text-decoration-none fw-bold">Create an account here</a>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>