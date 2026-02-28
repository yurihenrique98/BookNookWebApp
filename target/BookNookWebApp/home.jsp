<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, models.Book" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Book> books = (List<Book>) request.getAttribute("books");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookNook - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .welcome-header { 
            padding: 4rem 0; 
            background: linear-gradient(rgba(255,255,255,0.8), rgba(255,255,255,0.8)), 
                        url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?auto=format&fit=crop&w=1400&q=80');
            background-size: cover; background-position: center; border-bottom: 1px solid #dee2e6; 
        }
        .book-card { 
            border: none; border-radius: 15px; transition: transform 0.3s, box-shadow 0.3s; background: #fff;
        }
        .book-card:hover { transform: translateY(-10px); box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .book-cover { 
            height: 250px; background: #e9ecef; border-radius: 15px 15px 0 0;
            display: flex; align-items: center; justify-content: center; font-size: 3rem;
        }
        .section-title { position: relative; margin-bottom: 3rem; }
        .section-title::after {
            content: ''; width: 60px; height: 3px; background: #0d6efd;
            position: absolute; bottom: -10px; left: 50%; transform: translateX(-50%);
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <%@ include file="top_info.jsp" %>
    <%@ include file="navbar.jsp" %>

    <div class="welcome-header shadow-sm">
        <div class="container text-center">
            <h1 class="display-4 fw-bold text-dark">Welcome back, <%= username %>!</h1>
            <p class="lead text-secondary">Ready to discover your next great read?</p>
            
            <div class="mt-4 d-flex justify-content-center gap-2">
                <a href="search.jsp" class="btn btn-primary btn-lg px-4 shadow-sm">
                    <i class="fas fa-search"></i> Search Catalog
                </a>
                
                <% if ("admin".equals(role)) { %>
                    <a href="admin_Dashboard.jsp" class="btn btn-dark btn-lg px-4 shadow-sm">
                        <i class="fas fa-user-shield"></i> Admin Panel
                    </a>
                <% } %>
            </div>
        </div>
    </div>

    <main id="collection" class="container py-5 flex-grow-1">
        <div class="row">
            <div class="col-12 text-center mb-5">
                <h2 class="fw-bold section-title">Our Collection</h2>
            </div>
        </div>

        <div class="row g-4">
            <% if (books != null && !books.isEmpty()) { 
                for (Book book : books) { %>
                <div class="col-md-4 col-lg-3">
                    <div class="card h-100 book-card shadow-sm">
                        <div class="book-cover">📖</div>
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold text-truncate"><%= book.getTitle() %></h5>
                            <p class="card-text text-muted small">by <%= book.getAuthor() %></p>
                            <p class="fw-bold text-primary mb-3">£<%= String.format("%.2f", book.getPrice()) %></p>
                            
                            <form action="addToCart" method="post">
                                <input type="hidden" name="bookId" value="<%= book.getId() %>">
                                <button type="submit" class="btn btn-outline-primary btn-sm rounded-pill w-100">
                                    <i class="fas fa-cart-plus"></i> Add to Cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            <% } } else { %>
                <div class="col-12 text-center py-5">
                    <div class="alert alert-warning d-inline-block">
                        No books available at the moment.
                    </div>
                </div>
            <% } %>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>