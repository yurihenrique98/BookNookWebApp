package models;

public class User {
    private int id;
    private String username;
    private String role;
    private String email;
    private boolean active;

    // Constructor
    public User(int id, String username, String role, String email, boolean active) {
        this.id = id;
        this.username = username;
        this.role = role;
        this.email = email;
        this.active = active;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getRole() {
        return role;
    }

    public String getEmail() {
        return email;
    }

    public boolean isActive() {
        return active;
    }

    // toString method (used in testing and debugging)
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", role='" + role + '\'' +
                ", email='" + email + '\'' +
                ", active=" + active +
                '}';
    }
}