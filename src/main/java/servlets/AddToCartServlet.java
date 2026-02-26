package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet to handle adding books to the user's shopping cart.
 */
public class AddToCartServlet extends HttpServlet {

    @Override
    @SuppressWarnings("unchecked") // Suppress unchecked cast warning
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve parameters from the form submission
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String title = request.getParameter("title");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Get or create the HTTP session for the user
        HttpSession session = request.getSession();

        // Try to retrieve the cart from session
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        // If cart doesn't exist, create a new one
        if (cart == null) {
            cart = new ArrayList<>();
        }

        boolean found = false;

        // Check if the item already exists in the cart
        for (Map<String, Object> item : cart) {
            if ((int) item.get("bookId") == bookId) {
                // If found, increase the quantity
                int existingQty = (int) item.get("quantity");
                item.put("quantity", existingQty + quantity);
                found = true;
                break;
            }
        }

        // If item not in cart, add it as a new entry
        if (!found) {
            Map<String, Object> item = new HashMap<>();
            item.put("bookId", bookId);
            item.put("title", title);
            item.put("price", price);
            item.put("quantity", quantity);
            cart.add(item);
        }

        // Save updated cart in session
        session.setAttribute("cart", cart);

        // Redirect user to the search page
        response.sendRedirect("search.jsp");
    }
}