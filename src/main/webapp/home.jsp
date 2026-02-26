<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
</head>
<body>
    <%
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <h2>Welcome, <%= username %>!</h2>
    <p>Your role is: <%= role != null ? role : "unknown" %></p>

    <p><a href="login.jsp">Logout</a></p>
</body>
</html>