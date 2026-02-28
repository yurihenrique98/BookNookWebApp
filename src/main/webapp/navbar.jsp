<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Safely get the cart count
    List<Map<String, Object>> navCart = (List<Map<String, Object>>) session.getAttribute("cart");
    int cartCount = (navCart != null) ? navCart.size() : 0;
    
    // Define the base path once for cleaner code
    String base = request.getContextPath();
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
  <div class="container">
    <%-- FIX: Use absolute path for logo --%>
    <a class="navbar-brand fw-bold d-flex align-items-center" href="<%= base %>/home">
        <i class="fa-solid fa-book-bookmark me-2 text-primary"></i>BookNook
    </a>
    
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto align-items-center">
        <li class="nav-item">
            <a class="nav-link" href="<%= base %>/home">Catalog</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<%= base %>/search.jsp">Search</a>
        </li>
        
        <li class="nav-item">
            <%-- FIX: Use absolute path for cart --%>
            <a href="<%= base %>/cart.jsp" class="nav-link position-relative me-3">
                <i class="fa-solid fa-cart-shopping"></i> Cart
                <% if (cartCount > 0) { %>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.7rem;">
                        <%= cartCount %>
                    </span>
                <% } %>
            </a>
        </li>

        <c:choose>
            <c:when test="${not empty sessionScope.username}">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle btn btn-outline-light btn-sm text-white px-3 ms-2" href="#" id="userDrop" role="button" data-bs-toggle="dropdown">
                        <i class="fa-solid fa-circle-user"></i> ${sessionScope.username}
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                        <li><a class="dropdown-item" href="<%= base %>/profile"><i class="fa-solid fa-id-card me-2"></i>My Profile</a></li>
                        <li><a class="dropdown-item" href="<%= base %>/orderHistory"><i class="fa-solid fa-box me-2"></i>Order History</a></li>
                        
                        <c:if test="${sessionScope.role eq 'admin'}">
                            <li><hr class="dropdown-divider"></li>
                            <li><h6 class="dropdown-header">Admin Tools</h6></li>
                            <li><a class="dropdown-item text-primary" href="<%= base %>/adminBook"><i class="fa-solid fa-pen-to-square me-2"></i>Manage Books</a></li>
                            <li><a class="dropdown-item text-primary" href="<%= base %>/adminUser"><i class="fa-solid fa-users-gear me-2"></i>Manage Users</a></li>
                        </c:if>
                        
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger fw-bold" href="<%= base %>/logout"><i class="fa-solid fa-right-from-bracket me-2"></i>Logout</a></li>
                    </ul>
                </li>
            </c:when>
            <c:otherwise>
                <li class="nav-item">
                    <a href="<%= base %>/login.jsp" class="btn btn-primary btn-sm ms-lg-3 px-4 rounded-pill">Login</a>
                </li>
            </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>