package servlets;

import java.io.IOException;
import java.util.List;

import Repositories.BookRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Book;

public class AdminBookServlet extends HttpServlet {

    BookRepository repo = new BookRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if (role == null || !role.equalsIgnoreCase("admin")) {
            response.sendRedirect("login.jsp?error=unauthorized");
            return;
        }

        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Book book = repo.getBookById(id);
            request.setAttribute("book", book);
            request.getRequestDispatcher("book_form.jsp").forward(request, response);
        } else {
            
            List<Book> books = repo.getAllBooks();
            request.setAttribute("books", books);
            request.getRequestDispatcher("admin_books.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                Book book = extractBookFromRequest(request, false);
                repo.addBook(book);
                response.sendRedirect("adminBook?success=added");

            } else if ("update".equals(action)) {
                Book book = extractBookFromRequest(request, true);
                repo.updateBook(book);
                response.sendRedirect("adminBook?success=updated");

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                repo.deleteBook(id);
                response.sendRedirect("adminBook?success=deleted");
            }
        } catch (NumberFormatException e) {
        
            response.sendRedirect("adminBook?error=invalidInput");
        }
    }

    private Book extractBookFromRequest(HttpServletRequest request, boolean includeId) {
        int id = includeId ? Integer.parseInt(request.getParameter("id")) : 0;
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        
        String priceStr = request.getParameter("price");
        double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
        
        String stockStr = request.getParameter("stock");
        int stock = (stockStr != null && !stockStr.isEmpty()) ? Integer.parseInt(stockStr) : 0;

        return new Book(id, title, author, category, price, stock);
    }
}