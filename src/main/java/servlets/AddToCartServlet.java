package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import Repositories.BookRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Book;

public class AddToCartServlet extends HttpServlet {
    
    private BookRepository bookRepo = new BookRepository();

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int bookId = Integer.parseInt(request.getParameter("bookId"));
            String qtyStr = request.getParameter("quantity");
            int quantityToAdd = (qtyStr != null) ? Integer.parseInt(qtyStr) : 1;

            Book book = bookRepo.getBookById(bookId);
            
            if (book == null) {
                response.sendRedirect("home?error=book_not_found");
                return;
            }

            HttpSession session = request.getSession();
            List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

            if (cart == null) {
                cart = new ArrayList<>();
            }

            boolean found = false;
            for (Map<String, Object> item : cart) {
                if ((int) item.get("bookId") == bookId) {
                    int existingQty = (int) item.get("quantity");
                    item.put("quantity", existingQty + quantityToAdd);
                    found = true;
                    break;
                }
            }

            if (!found) {
                Map<String, Object> item = new HashMap<>();
                item.put("bookId", book.getId());
                item.put("title", book.getTitle()); 
                item.put("price", book.getPrice());  
                item.put("quantity", quantityToAdd);
                cart.add(item);
            }

            session.setAttribute("cart", cart);

            response.sendRedirect("home?success=added");

        } catch (NumberFormatException e) {
            response.sendRedirect("home?error=invalid_data");
        }
    }
}