<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
    double total = 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - BookNook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .cart-container { background: white; border-radius: 15px; padding: 30px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); }
        .summary-card { border: none; border-radius: 15px; background-color: #ffffff; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .product-img-placeholder { width: 50px; height: 70px; background: #e9ecef; border-radius: 4px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
        .navbar-brand i { color: #0d6efd; } /* Fix for the logo icon color */
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <%@ include file="top_info.jsp" %>
    <%@ include file="navbar.jsp" %>

    <main class="container py-5 flex-grow-1">
        <div class="d-flex align-items-center mb-4">
            <i class="fa-solid fa-shopping-cart fa-2x me-3 text-primary"></i>
            <h2 class="fw-bold mb-0">Your Shopping Cart</h2>
        </div>

        <div class="row">
            <% if (cart == null || cart.isEmpty()) { %>
                <div class="col-12 text-center py-5">
                    <div class="display-1 mb-3 text-muted"><i class="fa-solid fa-cart-ghost"></i></div>
                    <h3 class="fw-bold">Your cart is empty</h3>
                    <p class="text-muted">Looks like you haven't added any books yet.</p>
                    <a href="home" class="btn btn-primary btn-lg mt-3 px-5 shadow">Start Shopping</a>
                </div>
            <% } else { %>
                <div class="col-lg-8">
                    <div class="cart-container mb-4">
                        <div class="table-responsive">
                            <table class="table align-middle">
                                <thead class="text-muted small text-uppercase">
                                    <tr>
                                        <th>Product</th>
                                        <th>Price</th>
                                        <th class="text-center">Quantity</th>
                                        <th>Subtotal</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    for (Map<String, Object> item : cart) {
                                        double price = (item.get("price") != null) ? (Double) item.get("price") : 0.0;
                                        int quantity = (item.get("quantity") != null) ? (Integer) item.get("quantity") : 1;
                                        int bookId = (Integer) item.get("bookId");
                                        double subtotal = price * quantity;
                                        total += subtotal;
                                    %>
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="product-img-placeholder me-3 text-muted">
                                                        <i class="fa-solid fa-book"></i>
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-0 fw-bold text-dark"><%= item.get("title") %></h6>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-muted">£<%= String.format("%.2f", price) %></td>
                                            <td class="text-center">
                                                <span class="badge bg-light text-dark border px-3 py-2"><%= quantity %></span>
                                            </td>
                                            <td class="fw-bold text-dark">£<%= String.format("%.2f", subtotal) %></td>
                                            <td class="text-end">
                                                <form method="post" action="removeFromCart">
                                                    <input type="hidden" name="bookId" value="<%= bookId %>">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger border-0">
                                                        <i class="fa-solid fa-trash-can"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <a href="home" class="text-decoration-none fw-bold text-primary">
                        <i class="fa-solid fa-chevron-left me-2"></i>Continue Shopping
                    </a>
                </div>

                <div class="col-lg-4">
                    <div class="card summary-card p-4 sticky-top" style="top: 100px;">
                        <h4 class="fw-bold mb-4">Order Summary</h4>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Subtotal</span>
                            <span class="fw-bold">£<%= String.format("%.2f", total) %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Shipping</span>
                            <span class="text-success fw-bold">FREE</span>
                        </div>
                        <hr class="my-3">
                        <div class="d-flex justify-content-between mb-4">
                            <h5 class="fw-bold mb-0">Total</h5>
                            <h5 class="fw-bold text-primary mb-0">£<%= String.format("%.2f", total) %></h5>
                        </div>

                        <%-- PROCEED TO CHECKOUT FORM --%>
                       <form method="post" action="${pageContext.request.contextPath}/checkout">
                            <input type="hidden" name="totalAmount" value="<%= total %>">
                            <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold shadow-sm py-3">
                                Proceed to Checkout <i class="fa-solid fa-arrow-right ms-2"></i>
                            </button>
                        </form>
                        
                        <div class="mt-4 text-center">
                            <div class="d-flex justify-content-center gap-3 text-muted mb-2" style="font-size: 1.2rem;">
                                <i class="fa-brands fa-cc-visa"></i>
                                <i class="fa-brands fa-cc-mastercard"></i>
                                <i class="fa-brands fa-cc-stripe"></i>
                            </div>
                            <small class="text-muted">
                                <i class="fa-solid fa-lock me-1"></i> Secure SSL Checkout
                            </small>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </main>

    <%@ include file="footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>