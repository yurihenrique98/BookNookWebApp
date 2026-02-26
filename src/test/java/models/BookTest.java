package models;

import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 * Unit tests for the Book model class.
 */
public class BookTest {

    private Book book;

    @Before
    public void setUp() {
        // Initialize a book object before each test
        book = new Book(1, "Test Title", "Test Author", "Test Category", 19.99, 10);
    }

    @Test
    public void testGetters() {
        assertEquals(1, book.getId());
        assertEquals("Test Title", book.getTitle());
        assertEquals("Test Author", book.getAuthor());
        assertEquals("Test Category", book.getCategory());
        assertEquals(19.99, book.getPrice(), 0.001);
        assertEquals(10, book.getStock());
    }

    @Test
    public void testSetters() {
        book.setStock(20);
        assertEquals(20, book.getStock());

        book.setPrice(25.99);
        assertEquals(25.99, book.getPrice(), 0.001);
    }
}