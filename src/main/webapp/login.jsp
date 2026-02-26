<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>

    <form method="post" action="login">
        Username: <input type="text" name="username" required><br/><br/>
        Password: <input type="password" name="password" required><br/><br/>
        <input type="submit" value="Login">
    </form>

    <p><a href="register.jsp">Don't have an account? Register here</a></p>

    <%-- Show messages based on query params --%>
    <% if (request.getParameter("error") != null) { %>
        <p style="color: red;">Invalid username or password.</p>
    <% } else if (request.getParameter("success") != null) { %>
        <p style="color: green;">Registration successful. Please login.</p>
    <% } else if (request.getParameter("logout") != null) { %>
        <p style="color: green;">You have been logged out successfully.</p>
    <% } %>
</body>
</html>