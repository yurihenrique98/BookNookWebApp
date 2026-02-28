<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, models.Book" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    if (!"admin".equals(role)) {
        response.sendRedirect("home"); 
        return;
    }

    List<Book> books = (List<Book>) request.getAttribute("books");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Books - BookNook Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body class="d-flex flex-column min-vh-100">

    <%@ include file="top_info.jsp" %>
    <%@ include file="navbar.jsp" %>

    <main class="container py-5 flex-grow-1">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold mb-0">Book Inventory</h2>
                <p class="text-muted">Currently managing <%= (books != null) ? books.size() : 0 %> titles</p>
            </div>
            <a href="bookForm" class="btn btn-primary btn-lg shadow-sm px-4">
                <i class="fas fa-plus"></i> Add New Book
            </a>
        </div>

        <div class="table-responsive bg-white rounded-3 shadow-sm p-3">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (books != null && !books.isEmpty()) {
                        for (Book book : books) { %>
                            <tr>
                                <td class="fw-bold text-dark"><%= book.getTitle() %></td>
                                <td><%= book.getAuthor() %></td>
                                <td><span class="badge bg-secondary opacity-75"><%= book.getCategory() %></span></td>
                                <td>£<%= String.format("%.2f", book.getPrice()) %></td>
                                <td><%= book.getStock() %></td>
                                <td class="text-center">
                                    <div class="d-flex justify-content-center">
                                        <form action="adminBook" method="post" class="me-2">
                                            <input type="hidden" name="action" value="edit">
                                            <input type="hidden" name="id" value="<%= book.getId() %>">
                                            <button type="submit" class="btn btn-sm btn-outline-primary">
                                                <i class="fas fa-edit"></i> Edit
                                            </button>
                                        </form>

                                        <form action="adminBook" method="post" onsubmit="return confirm('Are you sure you want to delete this book?');">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="<%= book.getId() %>">
                                            <button type="submit" class="btn btn-sm btn-outline-danger">
                                                <i class="fas fa-trash"></i> Delete
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                    <% } } else { %>
                        <tr>
                            <td colspan="6" class="text-center py-4 text-muted">No books found in inventory.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <div class="mt-4">
            <a href="home" class="text-decoration-none text-muted small">
                <i class="fas fa-arrow-left"></i> Return to Storefront
            </a>
        </div>
    </main>

    <%@ include file="footer.jsp" %>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>