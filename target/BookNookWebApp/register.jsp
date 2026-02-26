<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>Register</h2>

    <form method="post" action="register">
        Username: <input type="text" name="username" required><br/><br/>
        Password: <input type="password" name="password" required><br/><br/>
        Email: <input type="email" name="email" required><br/><br/>
        <input type="submit" value="Register">
    </form>

    <p><a href="login.jsp">Already have an account? Login here</a></p>

    <% if (request.getAttribute("error") != null) { %>
        <p style="color: red;"><%= request.getAttribute("error") %></p>
    <% } else if (request.getParameter("register") != null && request.getParameter("register").equals("success")) { %>
        <p style="color: green;">Registration successful. Please login.</p>
    <% } %>
</body>
</html>