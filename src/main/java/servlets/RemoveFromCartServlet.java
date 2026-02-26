package servlets;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet to remove an item from the user's cart based on the item index.
 */
public class RemoveFromCartServlet extends HttpServlet {

    /**
     * Handles POST requests to remove an item from the cart.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the index of the item to remove from the request
        int index = Integer.parseInt(request.getParameter("index"));

        // Retrieve the session and the cart list
        HttpSession session = request.getSession();

        @SuppressWarnings("unchecked") // Suppress unchecked cast warning
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        // Remove item from cart if index is valid
        if (cart != null && index >= 0 && index < cart.size()) {
            cart.remove(index);
        }

        // Update the session with the modified cart
        session.setAttribute("cart", cart);

        // Redirect to the cart page
        response.sendRedirect("cart.jsp");
    }
}