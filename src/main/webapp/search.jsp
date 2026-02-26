<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, models.Book" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    List<Book> searchResults = (List<Book>) request.getAttribute("results");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Search Books</title>
</head>
<body>
    <h1>Welcome <%= username != null ? username : "Guest" %></h1>

    <h2>🔍 Search Books</h2>
    <form action="search" method="post">
        <input type="text" name="keyword" placeholder="Enter title, author, or category" required>
        <input type="submit" value="Search">
    </form>

    <p><a href="cart.jsp">View Cart</a></p>

    <% if (searchResults != null && !searchResults.isEmpty()) { %>
        <h3>Results:</h3>
        <table border="1">
            <tr>
                <th>Title</th><th>Author</th><th>Category</th><th>Price</th><th>Stock</th><th>Action</th>
            </tr>
            <% for (Book book : searchResults) { %>
                <tr>
                    <td><%= book.getTitle() %></td>
                    <td><%= book.getAuthor() %></td>
                    <td><%= book.getCategory() %></td>
                    <td>£<%= book.getPrice() %></td>
                    <td><%= book.getStock() %></td>
                    <td>
                        <form method="post" action="addToCart">
                            <input type="hidden" name="bookId" value="<%= book.getId() %>">
                            <input type="hidden" name="title" value="<%= book.getTitle() %>">
                            <input type="hidden" name="price" value="<%= book.getPrice() %>">
                            <input type="number" name="quantity" value="1" min="1" max="<%= book.getStock() %>">
                            <input type="submit" value="Add to Cart">
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    <% } else if (searchResults != null) { %>
        <p>No results found.</p>
    <% } %>

    <p><a href="home.jsp">Back to Home</a></p>
</body>
</html>