package Repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.DBUtil;
import models.Book;

public class BookRepository {

    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT id, title, author, category, price, stock FROM books";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                books.add(extractBook(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error fetching all books: " + e.getMessage());
            e.printStackTrace();
        }

        return books;
    }
    public Book getBookById(int id) {
        String sql = "SELECT id, title, author, category, price, stock FROM books WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractBook(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching book by ID (" + id + "): " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    public void addBook(Book book) {
        String sql = "INSERT INTO books (title, author, category, price, stock) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            setBookParameters(stmt, book);
            stmt.executeUpdate();
            System.out.println("Book added successfully: " + book.getTitle());

        } catch (SQLException e) {
            System.err.println("Error adding book: " + e.getMessage());
            e.printStackTrace();
        }
    }
    public void updateBook(Book book) {
        String sql = "UPDATE books SET title=?, author=?, category=?, price=?, stock=? WHERE id=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            setBookParameters(stmt, book);
            stmt.setInt(6, book.getId());
            
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                System.out.println("Book updated successfully: ID " + book.getId());
            }

        } catch (SQLException e) {
            System.err.println("Error updating book: " + e.getMessage());
            e.printStackTrace();
        }
    }
    public void deleteBook(int id) {
        String sql = "DELETE FROM books WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                System.out.println("Book deleted successfully: ID " + id);
            }

        } catch (SQLException e) {
            System.err.println("Error deleting book: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private Book extractBook(ResultSet rs) throws SQLException {
        return new Book(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("author"),
                rs.getString("category"),
                rs.getDouble("price"),
                rs.getInt("stock")
        );
    }

    private void setBookParameters(PreparedStatement stmt, Book book) throws SQLException {
        stmt.setString(1, book.getTitle());
        stmt.setString(2, book.getAuthor());
        stmt.setString(3, book.getCategory());
        stmt.setDouble(4, book.getPrice());
        stmt.setInt(5, book.getStock());
    }
}