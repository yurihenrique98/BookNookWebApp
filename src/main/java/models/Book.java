package models;

public class Book {
    private int id;
    private String title;
    private String author;
    private String category;
    private double price;
    private int stock;

    public Book() {
    }

    public Book(int id, String title, String author, String category, double price, int stock) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.category = category;
        this.price = price;
        this.stock = stock;
    }

    public Book(String title, String author, String category, double price, int stock) {
        this.title = title;
        this.author = author;
        this.category = category;
        this.price = price;
        this.stock = stock;
    }

    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getAuthor() { return author; }
    public String getCategory() { return category; }
    public double getPrice() { return price; }
    public int getStock() { return stock; }

    public void setId(int id) { this.id = id; }
    public void setTitle(String title) { this.title = title; }
    public void setAuthor(String author) { this.author = author; }
    public void setCategory(String category) { this.category = category; }
    public void setPrice(double price) { this.price = price; }
    public void setStock(int stock) { this.stock = stock; }

    @Override
    public String toString() {
        return title + " by " + author + " - " + category + " - £" + String.format("%.2f", price) + " (" + stock + " in stock)";
    }
}