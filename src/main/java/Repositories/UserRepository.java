package Repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.DBUtil;
import models.User;

public class UserRepository {

    /**
     * Retrieves all users whose usernames match the given filter.
     * * @param filter Partial string to filter usernames.
     * @return List of matching User objects.
     */
    public List<User> getAllUsers(String filter) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, username, role, email, active FROM users WHERE username LIKE ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + filter + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    users.add(new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("role"),
                            rs.getString("email"),
                            rs.getBoolean("active")
                    ));
                }
            }

        } catch (SQLException e) {
            System.err.println("Error fetching users: " + e.getMessage());
            e.printStackTrace();
        }

        return users;
    }

    /**
     * Deactivates a user by setting their 'active' field to false (0).
     * * @param id The ID of the user to deactivate.
     */
    public void deactivateUser(int id) {
        String sql = "UPDATE users SET active = 0 WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
            System.out.println("User ID " + id + " has been deactivated.");

        } catch (SQLException e) {
            System.err.println("Error deactivating user: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Activates a user by setting their 'active' field to true (1).
     * This fixes the error in AdminUserServlet.
     * * @param id The ID of the user to activate.
     */
    public void activateUser(int id) {
        String sql = "UPDATE users SET active = 1 WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
            System.out.println("User ID " + id + " has been activated.");

        } catch (SQLException e) {
            System.err.println("Error activating user: " + e.getMessage());
            e.printStackTrace();
        }
    }
}