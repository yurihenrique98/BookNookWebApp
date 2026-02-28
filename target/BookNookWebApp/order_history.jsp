<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
    String username = (String) session.getAttribute("username");
    List<Map<String, Object>> orders = (List<Map<String, Object>>) request.getAttribute("orders");

    if (username == null) {
        response.sendRedirect("home");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - BookNook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .history-card { border: none; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); background: white; }
        .order-id { font-family: 'Courier New', Courier, monospace; font-weight: bold; }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">
    
    <%@ include file="top_info.jsp" %>
    <%@ include file="navbar.jsp" %>

    <main class="container py-5 flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="fw-bold mb-0">Your Order History</h2>
                    <span class="badge bg-primary rounded-pill px-3 py-2">
                        <i class="fas fa-box me-1"></i> <%= (orders != null) ? orders.size() : 0 %> Orders
                    </span>
                </div>

                <% if (orders == null || orders.isEmpty()) { %>
                    <div class="history-card p-5 text-center">
                        <div class="display-1 text-muted mb-3"><i class="fas fa-receipt"></i></div>
                        <h3>No orders found</h3>
                        <p class="text-muted">You haven't placed any orders yet. Time to find a new favorite book!</p>
                        <a href="home" class="btn btn-primary mt-3 shadow-sm px-4">Browse the Store</a>
                    </div>
                <% } else { %>
                    <div class="history-card overflow-hidden shadow-sm">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4">Order ID</th>
                                        <th>Date</th>
                                        <th>Total Amount</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Map<String, Object> order : orders) { %>
                                        <tr>
                                            <td class="ps-4">
                                                <span class="order-id text-primary">#<%= order.get("id") %></span>
                                            </td>
                                            <td>
                                                <div class="text-dark fw-medium"><i class="far fa-calendar-alt me-2 text-muted"></i><%= order.get("date") %></div>
                                            </td>
                                            <td>
                                                <span class="fw-bold text-success">
                                                    £<%= String.format("%.2f", Double.parseDouble(order.get("total").toString())) %>
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <form method="get" action="orderDetails">
                                                    <input type="hidden" name="orderId" value="<%= order.get("id") %>">
                                                    <button type="submit" class="btn btn-sm btn-outline-primary px-4 rounded-pill">
                                                        <i class="fas fa-eye me-1"></i> Details
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                <% } %>

                <div class="mt-4">
                    <a href="home" class="text-decoration-none text-muted small">
                        <i class="fas fa-arrow-left me-1"></i> Back to Home
                    </a>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>