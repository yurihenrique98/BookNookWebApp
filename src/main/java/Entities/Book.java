package Entities;

public class Book {
    private int id;
    private String title;
    private String author;
    private String category;
    private double price;
    private int stock;

    // Full constructor with ID (used when reading from DB)
    public Book(int id, String title, String author, String category, double price, int stock) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.category = category;
        this.price = price;
        this.stock = stock;
    }

    // Constructor without ID (used when inserting a new book)
    public Book(String title, String author, String category, double price, int stock) {
        this.title = title;
        this.author = author;
        this.category = category;
        this.price = price;
        this.stock = stock;
    }

    // Getters and setters
    public int getId() { return id; }

    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }

    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }

    public void setAuthor(String author) { this.author = author; }

    public String getCategory() { return category; }

    public void setCategory(String category) { this.category = category; }

    public double getPrice() { return price; }

    public void setPrice(double price) { this.price = price; }

    public int getStock() { return stock; }

    public void setStock(int stock) { this.stock = stock; }

    @Override
    public String toString() {
        return title + " by " + author + " - £" + price + " | Stock: " + stock;
    }
}