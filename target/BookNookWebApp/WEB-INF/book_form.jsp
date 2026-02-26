<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="models.Book" %>

<%
    // Get the book from the request and determine action
    Book book = (Book) request.getAttribute("book");
    String action = (book == null) ? "add" : "update";
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= action.equals("add") ? "Add Book" : "Edit Book" %></title>
</head>
<body>
    <h2><%= action.equals("add") ? " Add New Book" : " Edit Book" %></h2>

    <form method="post" action="adminBook">
        <!-- Action type -->
        <input type="hidden" name="action" value="<%= action %>">

        <% if (book != null) { %>
            <!-- Include ID for update -->
            <input type="hidden" name="id" value="<%= book.getId() %>">
        <% } %>

        <!-- Input fields -->
        <label>Title:</label>
        <input type="text" name="title" value="<%= book != null ? book.getTitle() : "" %>" required><br><br>

        <label>Author:</label>
        <input type="text" name="author" value="<%= book != null ? book.getAuthor() : "" %>" required><br><br>

        <label>Category:</label>
        <input type="text" name="category" value="<%= book != null ? book.getCategory() : "" %>" required><br><br>

        <label>Price (£):</label>
        <input type="number" step="0.01" name="price" value="<%= book != null ? book.getPrice() : "" %>" required><br><br>

        <label>Stock:</label>
        <input type="number" name="stock" value="<%= book != null ? book.getStock() : "" %>" required><br><br>

        <!-- Submit -->
        <input type="submit" value="<%= action.equals("add") ? "Add Book" : "Update Book" %>">
    </form>

    <p><a href="adminBook"> Back to Book List</a></p>
</body>
</html>