package models;

public class User {
    private int id;
    private String username;
    private String role;
    private String email;
    private boolean active;

    public User(int id, String username, String role, String email, boolean active) {
        this.id = id;
        this.username = username;
        this.role = role;
        this.email = email;
        this.active = active;
    }

    public User(String username, String email, String role) {
        this.username = username;
        this.email = email;
        this.role = role;
        this.active = true; 
    }

    public User() {}

    public int getId() { return id; }
    public String getUsername() { return username; }
    public String getRole() { return role; }
    public String getEmail() { return email; }
    public boolean isActive() { return active; }

    public void setId(int id) { this.id = id; }
    public void setUsername(String username) { this.username = username; }
    public void setRole(String role) { this.role = role; }
    public void setEmail(String email) { this.email = email; }
    public void setActive(boolean active) { this.active = active; }

    @Override
    public String toString() {
        return "User [id=" + id + ", username=" + username + ", role=" + role + 
               ", email=" + email + ", active=" + active + "]";
    }
}