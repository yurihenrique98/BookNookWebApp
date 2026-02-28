<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookNook - Create Account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .register-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 3rem 1rem;
            /* Optional: subtle background pattern */
            background-image: radial-gradient(#dee2e6 0.5px, transparent 0.5px);
            background-size: 20px 20px;
        }
        .register-card {
            background: white;
            padding: 2.5rem;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            width: 100%;
            max-width: 450px;
            border: 1px solid rgba(0,0,0,0.05);
        }
        .brand-icon {
            font-size: 3rem;
            display: block;
            margin-bottom: 0.5rem;
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <%@ include file="top_info.jsp" %>
    <%@ include file="navbar.jsp" %>

    <main class="register-wrapper">
        <div class="register-card text-center">
            <span class="brand-icon">📚</span>
            <h2 class="fw-bold mb-1">Create Account</h2>
            <p class="text-muted mb-4">Join the BookNook community</p>

            <%-- Error Handling --%>
            <% 
                Object errorMsg = request.getAttribute("error");
                if (errorMsg != null) { 
            %>
                <div class="alert alert-danger py-2 small border-0 shadow-sm mb-4" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i><%= errorMsg.toString() %>
                </div>
            <% } %>

            <form method="post" action="${pageContext.request.contextPath}/register" class="text-start">
                <div class="mb-3">
                    <label class="form-label fw-bold small text-uppercase text-muted">Username</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fas fa-user text-muted"></i></span>
                        <input type="text" name="username" class="form-control border-start-0 ps-0" placeholder="Choose a username" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold small text-uppercase text-muted">Email Address</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fas fa-envelope text-muted"></i></span>
                        <input type="email" name="email" class="form-control border-start-0 ps-0" placeholder="name@example.com" required>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold small text-uppercase text-muted">Password</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fas fa-lock text-muted"></i></span>
                        <input type="password" name="password" class="form-control border-start-0 ps-0" placeholder="Min. 6 characters" minlength="6" required>
                    </div>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg fw-bold shadow-sm">
                        Sign Up <i class="fas fa-arrow-right ms-2"></i>
                    </button>
                </div>
            </form>

            <div class="mt-4 pt-3 border-top">
                <p class="text-muted mb-0 small">Already have an account?</p>
                <a href="login.jsp" class="text-decoration-none fw-bold text-primary">Login here</a>
            </div>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>