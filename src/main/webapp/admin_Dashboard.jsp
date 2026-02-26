<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head><title>Admin Dashboard</title></head>
<body>
    <h2>Welcome Admin: <%= username %></h2>
    <ul>
        <li><a href="admin_books.jsp">Manage Books</a></li>
        <li><a href="admin_users.jsp">Manage Users</a></li>
        <li><a href="logout">Logout</a></li>
    </ul>
</body>
</html>