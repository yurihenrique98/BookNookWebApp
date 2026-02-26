package models;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class UserTest {
    private User user;

    @Before
    public void setup() {
        // Use the correct constructor and field names
        user = new User(1, "Admin User", "admin", "admin@example.com", true);
    }

    @Test
    public void testGetters() {
        assertEquals(1, user.getId());
        assertEquals("Admin User", user.getUsername());
        assertEquals("admin", user.getRole());
        assertEquals("admin@example.com", user.getEmail());
        assertTrue(user.isActive());
    }

    @Test
    public void testToString() {
        String result = user.toString();
        assertTrue(result.contains("Admin User"));
        assertTrue(result.contains("admin@example.com"));
        assertTrue(result.contains("admin"));
    }
}