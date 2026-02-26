<%@ page import="java.util.*" %>
<%
    List<Map<String, Object>> orders = (List<Map<String, Object>>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Order History</title>
</head>
<body>
    <h2> Your Order History</h2>

    <% if (orders == null || orders.isEmpty()) { %>
        <p>You haven't placed any orders yet.</p>
    <% } else { %>
        <table border="1">
            <tr><th>Order ID</th><th>Total</th><th>Date</th><th>Action</th></tr>
            <% for (Map<String, Object> order : orders) { %>
                <tr>
                    <td><%= order.get("id") %></td>
                    <td>£<%= order.get("total") %></td>
                    <td><%= order.get("date") %></td>
                    <td>
                        <form method="get" action="orderDetails">
                            <input type="hidden" name="orderId" value="<%= order.get("id") %>">
                            <input type="submit" value="View">
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    <% } %>

    <p><a href="home.jsp"> Back to Home</a></p>
</body>
</html>