package models;

/**
 * Represents an accessory product in the BookNook system.
 * Connected to a database table called `accessories`.
 * 
 * Author: Yuri Henrique
 */
public class Accessories {
    private int id;
    private String name;
    private double price;
    private int stock;

    public Accessories(int id, String name, double price, int stock) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.stock = stock;
    }

    public Accessories(String name, double price, int stock) {
        this.name = name;
        this.price = price;
        this.stock = stock;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }
}