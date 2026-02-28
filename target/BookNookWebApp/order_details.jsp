<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
    String username = (String) session.getAttribute("username");
    List<Map<String, Object>> items = (List<Map<String, Object>>) request.getAttribute("items");
    
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
    <title>Order Details - BookNook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .receipt-card { border: none; border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); overflow: hidden; }
        .receipt-header { background-color: #212529; color: white; padding: 25px; }
        .total-section { background-color: #f8f9fa; border-top: 2px dashed #dee2e6; padding: 20px; }
        .table thead th { border-top: none; }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <%@ include file="top_info.jsp" %>
    <%@ include file="navbar.jsp" %>
    
    <main class="container py-5 flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                
                <div class="card receipt-card">
                    <div class="receipt-header d-flex justify-content-between align-items-center shadow-sm">
                        <div>
                            <h4 class="mb-0 fw-bold"><i class="fas fa-file-invoice me-2"></i>Order Summary</h4>
                            <p class="mb-0 small opacity-75">Thank you for your purchase, <%= username %></p>
                        </div>
                        <div class="text-end">
                            <span class="badge bg-success px-3 py-2"><i class="fas fa-check-circle me-1"></i> PAID</span>
                        </div>
                    </div>

                    <div class="card-body p-4 bg-white">
                        <% if (items == null || items.isEmpty()) { %>
                            <div class="text-center py-5">
                                <div class="display-1 text-muted mb-3"><i class="fas fa-box-open"></i></div>
                                <p class="text-muted">No items found for this order.</p>
                                <a href="orderHistory" class="btn btn-primary px-4">Back to Orders</a>
                            </div>
                        <% } else { 
                            double runningTotal = 0;
                        %>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Book Title</th>
                                            <th class="text-center">Price</th>
                                            <th class="text-center">Qty</th>
                                            <th class="text-end">Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Map<String, Object> item : items) {
                                               double price = (item.get("price") != null) ? (Double)item.get("price") : 0.0;
                                               int qty = (item.get("quantity") != null) ? (Integer)item.get("quantity") : 0;
                                               double sub = price * qty;
                                               runningTotal += sub;
                                        %>
                                            <tr>
                                                <td>
                                                    <div class="fw-bold text-dark"><i class="fas fa-book me-2 text-muted"></i><%= item.get("title") %></div>
                                                </td>
                                                <td class="text-center text-muted">£<%= String.format("%.2f", price) %></td>
                                                <td class="text-center">
                                                    <span class="badge bg-light text-dark border px-2"><%= qty %></span>
                                                </td>
                                                <td class="text-end fw-bold">£<%= String.format("%.2f", sub) %></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <div class="total-section mt-3 rounded">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="text-muted fw-bold text-uppercase">Total Amount</span>
                                    <h2 class="fw-bold text-primary mb-0">£<%= String.format("%.2f", runningTotal) %></h2>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>

                <div class="mt-4 text-center">
                    <a href="orderHistory" class="btn btn-link text-decoration-none text-muted small fw-bold">
                        <i class="fas fa-history me-1"></i> BACK TO MY ORDER HISTORY
                    </a>
                </div>

            </div>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>