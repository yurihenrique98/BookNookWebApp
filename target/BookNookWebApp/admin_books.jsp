<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, models.Book" %>

<%
    // Restrict access to admin users only
    String role = (String) session.getAttribute("role");
    if (!"admin".equals(role)) {
        response.sendRedirect("home.jsp");
        return;
    }

    // Retrieve books passed from servlet
    List<Book> books = (List<Book>) request.getAttribute("books");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Book Management</title>
</head>
<body>
    <h2> Admin - Manage Books</h2>

    <p><a href="bookForm"> Add New Book</a></p> <!-- Fixed this line -->

    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Price</th>
            <th>Stock</th>
            <th>Actions</th>
        </tr>

        <% if (books != null) {
            for (Book book : books) { %>
                <tr>
                    <td><%= book.getTitle() %></td>
                    <td><%= book.getAuthor() %></td>
                    <td><%= book.getCategory() %></td>
                    <td>£<%= book.getPrice() %></td>
                    <td><%= book.getStock() %></td>
                    <td>
                        <!-- Edit Book Form -->
                        <form action="adminBook" method="post" style="display:inline">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="<%= book.getId() %>">
                            <input type="submit" value="Edit">
                        </form>

                        <!-- Delete Book Form -->
                        <form action="adminBook" method="post" style="display:inline">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= book.getId() %>">
                            <input type="submit" value="Delete" onclick="return confirm('Delete this book?')">
                        </form>
                    </td>
                </tr>
        <%  }} %>
    </table>

    <p><a href="home.jsp"> Back to Home</a></p>
</body>
</html>