package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import models.Book;

public class BookDAO {
    
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found: " + e.getMessage());
        }

        String sql = "SELECT * FROM books";
        
        String url = "jdbc:sqlite:/Volumes/Extreme_SSD/Folders/Uni_Material/2nd_Year /First_part/Object _Oriented _Design_and_Development/AE2_RESIT/BookNook/BookNook.db";

        try (Connection conn = DriverManager.getConnection(url);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getDouble("price"));
                book.setCategory(rs.getString("category"));
                book.setStock(rs.getInt("stock"));
                
                books.add(book);
            }
            
            System.out.println("DAO Success: Retrieved " + books.size() + " books.");

        } catch (SQLException e) {
            System.err.println("Database Error: " + e.getMessage());
            e.printStackTrace();
        }
        return books;
    }
}