<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Successful - BookNook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        
        /* This ensures the card centers perfectly between the header and footer */
        .content-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 3rem 0;
        }

        .success-card { 
            background: white; 
            border-radius: 20px; 
            padding: 3rem; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.08); 
            text-align: center;
            width: 100%;
            max-width: 500px;
        }

        .checkmark-circle {
            width: 80px;
            height: 80px;
            background-color: #d1e7dd;
            color: #0f5132;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin: 0 auto 1.5rem;
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <%-- 1. Top Utility Bar --%>
    <%@ include file="top_info.jsp" %>

    <%-- 2. Success Content centered in the middle --%>
    <div class="content-wrapper">
        <div class="container d-flex justify-content-center">
            <div class="success-card shadow-lg">
                <div class="checkmark-circle shadow-sm">✓</div>
                <h2 class="fw-bold mb-3">Order Confirmed!</h2>
                <p class="text-muted mb-4">
                    Thank you for shopping at <strong>BookNook</strong>. 
                    Your order has been placed successfully and is being processed.
                </p>
                
                <div class="d-grid gap-2">
                    <%-- FIX 1: Point to 'home' Servlet to reload books --%>
                    <a href="home" class="btn btn-primary btn-lg fw-bold shadow-sm">Continue Shopping</a>
                    
                    <%-- FIX 2: Point to 'orderHistory' Servlet to load the user's order list --%>
                    <a href="orderHistory" class="btn btn-outline-secondary">View Order History</a>
                </div>

                <hr class="my-4 text-muted">

                <p class="small text-muted mb-0">
                    <%-- If you have a contact servlet, use it here, otherwise .jsp is fine for static pages --%>
                    Need help? <a href="contact.jsp" class="text-decoration-none">Contact Support</a>
                </p>
            </div>
        </div>
    </div>

    <%-- 3. Footer --%>
    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>