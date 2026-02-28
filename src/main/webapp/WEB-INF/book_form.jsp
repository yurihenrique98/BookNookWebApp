<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="models.Book" %>

<%
    // Ensure we don't crash if the attribute is missing
    Book book = (Book) request.getAttribute("book");
    boolean isEdit = (book != null);
    String action = isEdit ? "update" : "add";
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "Edit Book" : "Add Book" %></title>
    <style>
        label { display: inline-block; width: 100px; margin-bottom: 10px; }
        input { margin-bottom: 10px; }
    </style>
</head>
<body>
    <h2><%= isEdit ? "Edit Existing Book" : "Add New Book" %></h2>

    <form method="post" action="adminBook">
        <input type="hidden" name="action" value="<%= action %>">

        <% if (isEdit) { %>
            <input type="hidden" name="id" value="<%= book.getId() %>">
        <% } %>

        <label>Title:</label>
        <input type="text" name="title" value="<%= isEdit ? book.getTitle() : "" %>" required><br>

        <label>Author:</label>
        <input type="text" name="author" value="<%= isEdit ? book.getAuthor() : "" %>" required><br>

        <label>Category:</label>
        <input type="text" name="category" value="<%= isEdit ? book.getCategory() : "" %>" required><br>

        <label>Price (£):</label>
        <input type="number" step="0.01" name="price" value="<%= isEdit ? book.getPrice() : "" %>" required><br>

        <label>Stock:</label>
        <input type="number" name="stock" value="<%= isEdit ? book.getStock() : "" %>" required><br>

        <input type="submit" value="<%= isEdit ? "Update Book" : "Add Book" %>">
    </form>

    <p><a href="adminBook">Back to Book List</a></p>
</body>
</html>