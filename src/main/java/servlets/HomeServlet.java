package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dao.BookDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Book;

public class HomeServlet extends HttpServlet {
   
    private BookDAO bookDAO = new BookDAO(); 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Book> allBooks;
        
        try {
            allBooks = bookDAO.getAllBooks();
            
            if (allBooks == null) {
                allBooks = new ArrayList<>();
            }
            
            System.out.println("Servlet Debug: Found " + allBooks.size() + " books.");
            
            request.setAttribute("books", allBooks);
            
        } catch (Exception e) {
            System.err.println("HomeServlet Error: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("books", new ArrayList<Book>());
            request.setAttribute("errorMessage", "Unable to load the catalog. Please try again later.");
        }
        
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}