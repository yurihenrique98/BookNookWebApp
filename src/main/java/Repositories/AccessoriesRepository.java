package Repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.DBUtil;
import models.Accessories;

public class AccessoriesRepository {

    public static List<Accessories> getAllAccessories() {
        List<Accessories> list = new ArrayList<>();
        String query = "SELECT id, name, price, stock FROM accessories";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(new Accessories(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("stock")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching accessories: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public static Accessories getAccessoryById(int id) {
        String query = "SELECT * FROM accessories WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Accessories(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("stock")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean addAccessory(Accessories acc) {
        String query = "INSERT INTO accessories (name, price, stock) VALUES (?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, acc.getName());
            stmt.setDouble(2, acc.getPrice());
            stmt.setInt(3, acc.getStock());

            int result = stmt.executeUpdate();
            if (result > 0) {
                System.out.println("Accessory added: " + acc.getName());
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean updateStock(int accessoryId, int newStock) {
        String query = "UPDATE accessories SET stock = ? WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
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