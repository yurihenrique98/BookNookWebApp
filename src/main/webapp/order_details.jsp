<%@ page import="java.util.*" %>
<%
    List<Map<String, Object>> items = (List<Map<String, Object>>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Details</title>
</head>
<body>
    <h2> Order Details</h2>

    <% if (items == null || items.isEmpty()) { %>
        <p>No items found for this order.</p>
    <% } else { 
        double total = 0;
    %>
        <table border="1">
            <tr><th>Title</th><th>Price</th><th>Quantity</th><th>Subtotal</th></tr>
            <% for (Map<String, Object> item : items) {
                   double price = (double) item.get("price");
                   int qty = (int) item.get("quantity");
                   double sub = price * qty;
                   total += sub;
            %>
                <tr>
                    <td><%= item.get("title") %></td>
                    <td>£<%= price %></td>
                    <td><%= qty %></td>
                    <td>£<%= sub %></td>
                </tr>
            <% } %>
        </table>
        <h3>Total: £<%= total %></h3>
    <% } %>

    <p><a href="orderHistory">⬅ Back to Order History</a></p>
</body>
</html>