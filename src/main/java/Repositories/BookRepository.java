package Repositories;

import models.Book;
import dao.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * BookRepository handles all interactions with the 'books' table in the database.
 * This includes CRUD operations: Create, Read, Update, and Delete.
 */
public class BookRepository {

    /**
     * Retrieves all books from the database.
     * 
     * @return List of all books available in the 'books' table.
     */
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                books.add(new Book(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("category"),
                        rs.getDouble("price"),
                        rs.getInt("stock")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    /**
     * Retrieves a single book by its ID.
     * 
     * @param id The ID of the book to retrieve.
     * @return Book object if found, null otherwise.
     */
    public Book getBookById(int id) {
        String sql = "SELECT * FROM books WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Book(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("category"),
                        rs.getDouble("price"),
                        rs.getInt("stock")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Adds a new book to the database.
     * 
     * @param book Book object containing title, author, category, price, and stock.
     */
    public void addBook(Book book) {
        String sql = "INSERT INTO books (title, author, category, price, stock) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getCategory());
            stmt.setDouble(4, book.getPrice());
            stmt.setInt(5, book.getStock());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Updates an existing book in the database.
     * 
     * @param book Book object with updated values (must include valid ID).
     */
    public void updateBook(Book book) {
        String sql = "UPDATE books SET title=?, author=?, category=?, price=?, stock=? WHERE id=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getCategory());
            stmt.setDouble(4, book.getPrice());
            stmt.setInt(5, book.getStock());
            stmt.setInt(6, book.getId());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Deletes a book from the database by its ID.
     * 
     * @param id The ID of the book to be deleted.
     */
    public void deleteBook(int id) {
        String sql = "DELETE FROM books WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}