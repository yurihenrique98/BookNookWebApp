package Repositories;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Accessories;

/**
 * Handles all database operations for accessories.
 * This includes retrieving all accessories, adding new ones, and updating stock quantities.
 */
public class AccessoriesRepository {

    // SQLite database connection string
    private static final String DB_URL = "jdbc:sqlite:AE2_RESIT.db";

    /**
     * Retrieves all accessories from the database.
     * 
     * @return List of Accessories objects retrieved from the 'accessories' table.
     */
    public static List<Accessories> getAllAccessories() {
        List<Accessories> list = new ArrayList<>();
        String query = "SELECT * FROM accessories";

        try (Connection conn = DriverManager.getConnection(DB_URL);
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Accessories accessory = new Accessories(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("stock")
                );
                list.add(accessory);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 
     * @param acc Accessory object containing name, price, and stock
     * @return true if insertion was successful, false otherwise
     */
    public static boolean addAccessory(Accessories acc) {
        String query = "INSERT INTO accessories (name, price, stock) VALUES (?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(DB_URL);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, acc.getName());
            stmt.setDouble(2, acc.getPrice());
            stmt.setInt(3, acc.getStock());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates the stock quantity of an existing accessory.
     * 
     * @param accessoryId ID of the accessory to update
     * @param newStock New stock value to set
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateStock(int accessoryId, int newStock) {
        String query = "UPDATE accessories SET stock = ? WHERE id = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, newStock);
            stmt.setInt(2, accessoryId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}