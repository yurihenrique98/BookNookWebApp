package Repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dao.DBUtil;
import models.User;

/**
 * Handles all database operations related to the 'users' table,
 * including fetching user records and updating their active status.
 */
public class UserRepository {

    /**
     * Retrieves all users whose usernames match the given filter.
     * 
     * @param filter Partial string to filter usernames.
     * @return List of matching User objects.
     */
    public List<User> getAllUsers(String filter) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, username, role, email, active FROM users WHERE username LIKE ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + filter + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("role"),
                        rs.getString("email"),
                        rs.getBoolean("active")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    /**
     * Deactivates a user by setting their 'active' field to false (0).
     * 
     * @param id The ID of the user to deactivate.
     */
    public void deactivateUser(int id) {
        String sql = "UPDATE users SET active = 0 WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}