package servlets;

import Repositories.BookRepository;
import models.Book;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for managing books through the admin interface.
 * Supports operations: view, add, edit, update, delete.
 */
public class AdminBookServlet extends HttpServlet {

    // Repository to handle database operations for books
    BookRepository repo = new BookRepository();

    /**
     * Handles GET requests to display all books in the admin view.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Book> books = repo.getAllBooks(); // Retrieve all books from DB
        request.setAttribute("books", books);  // Pass books to JSP page
        request.getRequestDispatcher("admin_books.jsp").forward(request, response); // Forward to view
    }

    /**
     * Handles POST requests for add, edit, update, and delete actions on books.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action"); // Determine the action requested

        if ("add".equals(action)) {
            // Handle book creation
            Book book = extractBookFromRequest(request, false);
            repo.addBook(book);
            response.sendRedirect("adminBook");

        } else if ("edit".equals(action)) {
            // Forward to edit form for selected book
            int id = Integer.parseInt(request.getParameter("id"));
            Book book = repo.getBookById(id);
            request.setAttribute("book", book);
            request.getRequestDispatcher("book_form.jsp").forward(request, response);

        } else if ("update".equals(action)) {
            // Update book details
            Book book = extractBookFromRequest(request, true);
            repo.updateBook(book);
            response.sendRedirect("adminBook");

        } else if ("delete".equals(action)) {
            // Delete selected book
            int id = Integer.parseInt(request.getParameter("id"));
            repo.deleteBook(id);
            response.sendRedirect("adminBook");
        }
    }

    /**
     * Helper method to extract book details from the form submission.
     * 
     * @param request The HTTP request containing form data
     * @param includeId Whether to include the book ID (true for update)
     * @return A Book object populated with request data
     */
    private Book extractBookFromRequest(HttpServletRequest request, boolean includeId) {
        int id = includeId ? Integer.parseInt(request.getParameter("id")) : 0;
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        return new Book(id, title, author, category, price, stock);
    }
}