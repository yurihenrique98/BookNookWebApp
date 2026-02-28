package models;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import org.junit.Test;

public class CategoryTest {

    @Test
    public void testGetters() {
        Category category = new Category("Fiction");
        assertEquals("Fiction", category.getName());
    }

    @Test
    public void testToString() {
        Category category = new Category("Science");
        String result = category.toString();

        assertTrue(result.contains("Science"));
    }
}