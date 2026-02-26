<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
    String username = (String) session.getAttribute("username");
    Map<String, String> profile = (Map<String, String>) request.getAttribute("profile");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile</title>
</head>
<body>
    <h2>👤 Update Your Profile</h2>

    <form method="post" action="profile">
        <input type="hidden" name="username" value="<%= username %>">

        Email: <input type="email" name="email" value="<%= profile != null ? profile.get("email") : "" %>"><br><br>
        Phone: <input type="text" name="phone" value="<%= profile != null ? profile.get("phone") : "" %>"><br><br>
        Address: <input type="text" name="address" value="<%= profile != null ? profile.get("address") : "" %>"><br><br>
        New Password: <input type="password" name="password" placeholder="Leave blank to keep current"><br><br>

        <input type="submit" value="Update Profile">
    </form>

    <p><a href="home.jsp">⬅ Back to Home</a></p>
</body>
</html>