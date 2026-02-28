<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    Map<String, String> profile = (Map<String, String>) request.getAttribute("profile");

    if (username == null) {
        response.sendRedirect("home");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookNook - My Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f4f7f6; }
        .profile-card { border: none; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); overflow: hidden; }
        .profile-header { background: #212529; color: white; padding: 2rem; text-align: center; }
        .btn-update { background-color: #212529; color: white; border: none; padding: 10px 30px; }
        .btn-update:hover { background-color: #343a40; color: white; }
        .form-label { font-size: 0.75rem; letter-spacing: 0.5px; }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <%@ include file="top_info.jsp" %>
    <%@ include file="navbar.jsp" %>

    <div class="container py-5 flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                
                <% if (request.getParameter("updateSuccess") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show shadow-sm mb-4 border-0" role="alert">
                        <i class="fas fa-check-circle me-2"></i> Profile updated successfully!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

                <div class="card profile-card border-0 shadow-sm">
                    <div class="profile-header">
                        <div class="mb-3">
                            <img src="https://ui-avatars.com/api/?name=<%= username %>&background=random&size=100" 
                                 class="rounded-circle border border-3 border-white shadow-sm" alt="Profile">
                        </div>
                        <h3 class="mb-1 fw-bold"><%= username %></h3>
                        <span class="badge bg-primary text-uppercase px-3 py-2 shadow-sm"><%= role %></span>
                    </div>
                    
                    <div class="card-body p-4 bg-white">
                        <h5 class="fw-bold mb-4 text-center text-dark">Account Settings</h5>
                        
                        <form method="post" action="profile">
                            <input type="hidden" name="username" value="<%= username %>">

                            <div class="mb-3">
                                <label class="form-label fw-bold text-uppercase text-muted"><i class="fas fa-envelope me-1"></i> Email Address</label>
                                <input type="email" name="email" class="form-control form-control-lg fs-6" 
                                       value="<%= profile != null ? profile.get("email") : "" %>" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold text-uppercase text-muted"><i class="fas fa-phone me-1"></i> Phone Number</label>
                                <input type="text" name="phone" class="form-control form-control-lg fs-6" 
                                       value="<%= profile != null ? profile.get("phone") : "" %>">
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold text-uppercase text-muted"><i class="fas fa-map-marker-alt me-1"></i> Home Address</label>
                                <textarea name="address" class="form-control fs-6" rows="2"><%= profile != null ? profile.get("address") : "" %></textarea>
                            </div>

                            <hr class="my-4 opacity-25">
                            
                            <div class="mb-4">
                                <label class="form-label fw-bold text-uppercase text-muted"><i class="fas fa-lock me-1"></i> Security</label>
                                <input type="password" name="password" class="form-control form-control-lg fs-6" 
                                       placeholder="New password (leave blank to keep current)">
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-update fw-bold shadow-sm btn-lg">
                                    Update Profile
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <div class="card-footer text-center py-3 bg-light border-0">
                        <a href="home" class="text-decoration-none text-muted small">
                            <i class="fas fa-arrow-left me-1"></i> Return to Store
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>