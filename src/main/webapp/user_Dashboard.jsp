<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head><title>User Dashboard</title></head>
<body>
    <h2>Welcome, <%= username %></h2>
    <ul>
        <li><a href="search.jsp">Search Books</a></li>
        <li><a href="cart.jsp">View Cart</a></li>
        <li><a href="logout">Logout</a></li>
    </ul>
</body>
</html>