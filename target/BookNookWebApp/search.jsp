<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, models.Book" %>
<%
    List<Book> searchResults = (List<Book>) request.getAttribute("results");
    String keyword = (String) request.getAttribute("keyword");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - BookNook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .search-header { 
            background: white; 
            padding: 3rem 0; 
            border-bottom: 1px solid #eee;
            margin-bottom: 2rem;
        }
        .book-card { 
            border: none; 
            border-radius: 12px; 
            transition: transform 0.2s, box-shadow 0.2s; 
            background: #fff;
        }
        .book-card:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 10px 20px rgba(0,0,0,0.08); 
        }
        .book-cover-placeholder {
            height: 200px;
            background: #e9ecef;
            border-radius: 12px 12px 0 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
        }
        .search-bar-container {
            max-width: 600px;
            margin: 0 auto;
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <%@ include file="top_info.jsp" %>
    <%@ include file="navbar.jsp" %>

    <div class="search-header shadow-sm">
        <div class="container text-center">
            <h1 class="fw-bold mb-3"><i class="fas fa-search me-2 text-primary"></i>Find Your Next Story</h1>
            <div class="search-bar-container">
                <form action="search" method="post" class="input-group shadow-sm">
                    <input type="text" name="keyword" class="form-control form-control-lg border-end-0" 
                           placeholder="Search by title or author..." 
                           value="<%= keyword != null ? keyword : "" %>" required>
                    <button class="btn btn-primary px-4 fw-bold" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
                <% if (keyword != null) { %>
                    <p class="mt-3 text-muted">Showing results for: <span class="fw-bold text-primary">"<%= keyword %>"</span></p>
                <% } %>
            </div>
        </div>
    </div>

    <main class="container mb-5 flex-grow-1">
        <div class="row g-4">
            <% if (searchResults != null && !searchResults.isEmpty()) { 
                for (Book book : searchResults) { %>
                <div class="col-md-4 col-lg-3">
                    <div class="card h-100 book-card shadow-sm border-0">
                        <div class="book-cover-placeholder">📖</div>
                        <div class="card-body d-flex flex-column text-center">
                            <h6 class="card-title fw-bold text-dark mb-1 text-truncate"><%= book.getTitle() %></h6>
                            <p class="card-text text-muted small mb-2">by <%= book.getAuthor() %></p>
                            <h5 class="text-primary fw-bold mt-auto mb-3">£<%= String.format("%.2f", book.getPrice()) %></h5>
                            
                            <form action="addToCart" method="post">
                                <input type="hidden" name="bookId" value="<%= book.getId() %>">
                                <button type="submit" class="btn btn-outline-primary btn-sm rounded-pill w-100 fw-bold">
                                    <i class="fas fa-cart-plus me-1"></i> Add to Cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            <% } } else if (keyword != null) { %>
                <div class="col-12 text-center py-5">
                    <div class="display-1 text-muted mb-3"><i class="fas fa-search-minus"></i></div>
                    <h3 class="fw-bold">No books found</h3>
                    <p class="text-muted">We couldn't find anything matching your search. Try a different keyword!</p>
                    <a href="home" class="btn btn-primary mt-2 px-4 shadow-sm">View All Books</a>
                </div>
            <% } else { %>
                <div class="col-12 text-center py-5">
                    <p class="text-muted"><i class="fas fa-info-circle me-1"></i> Enter a keyword above to search our collection.</p>
                </div>
            <% } %>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>