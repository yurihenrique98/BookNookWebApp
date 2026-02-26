<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
    // Retrieve cart from session
    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
    double total = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
</head>
<body>
    <h2>Your Shopping Cart</h2>

    <% if (cart == null || cart.isEmpty()) { %>
        <p>Your cart is empty.</p>
    <% } else { %>
        <table border="1">
            <tr>
                <th>Title</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
                <th>Action</th>
            </tr>

            <% for (int i = 0; i < cart.size(); i++) {
                Map<String, Object> item = cart.get(i);
                double price = (double) item.get("price");
                int quantity = (int) item.get("quantity");
                double subtotal = price * quantity;
                total += subtotal;
            %>
                <tr>
                    <td><%= item.get("title") %></td>
                    <td>£<%= String.format("%.2f", price) %></td>
                    <td><%= quantity %></td>
                    <td>£<%= String.format("%.2f", subtotal) %></td>
                    <td>
                        <form method="post" action="removeFromCart">
                            <input type="hidden" name="index" value="<%= i %>">
                            <input type="submit" value="Remove">
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>

        <h3>Total: £<%= String.format("%.2f", total) %></h3>

        <form method="post" action="checkout">
            <input type="submit" value="Checkout">
        </form>
    <% } %>

    <p><a href="search.jsp"> Continue Shopping</a></p>
</body>
</html>