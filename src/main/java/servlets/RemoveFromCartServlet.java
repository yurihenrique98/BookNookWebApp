package servlets;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookIdStr = request.getParameter("bookId");
        
        if (bookIdStr != null) {
            int bookId = Integer.parseInt(bookIdStr);
            HttpSession session = request.getSession();

            @SuppressWarnings("unchecked")
            List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

            if (cart != null) {

                Iterator<Map<String, Object>> iterator = cart.iterator();
                while (iterator.hasNext()) {
                    Map<String, Object> item = iterator.next();
                    if ((int) item.get("bookId") == bookId) {
                        iterator.remove();
                        break; 
                    }
                }
 
                if (cart.isEmpty()) {
                    session.removeAttribute("cart");
                } else {
                    session.setAttribute("cart", cart);
                }
            }
        }

        response.sendRedirect("cart.jsp");
    }
}