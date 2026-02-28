--
-- File generated with SQLiteStudio v3.4.13 on Sat Feb 28 21:32:44 2026
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: books
CREATE TABLE IF NOT EXISTS books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    category TEXT NOT NULL,
    price REAL NOT NULL,
    stock INTEGER NOT NULL
);
INSERT INTO books (id, title, author, category, price, stock) VALUES (1, 'Clean Code', 'Robert C. Martin', 'Programming', 29.99, 9);
INSERT INTO books (id, title, author, category, price, stock) VALUES (2, '1984', 'George Orwell', 'Fiction', 9.99, 14);
INSERT INTO books (id, title, author, category, price, stock) VALUES (3, 'The Pragmatic Programmer', 'Andrew Hunt', 'Programming', 34.99, 15);
INSERT INTO books (id, title, author, category, price, stock) VALUES (4, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 8.5, 29);
INSERT INTO books (id, title, author, category, price, stock) VALUES (5, 'Atomic Habits', 'James Clear', 'Self-help', 18.0, 15);
INSERT INTO books (id, title, author, category, price, stock) VALUES (6, 'Harry Potter', 'Unkown', 'Fiction', 14.99, 99);

-- Table: order_items
CREATE TABLE IF NOT EXISTS order_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER,
    book_id INTEGER,
    quantity INTEGER,
    price REAL,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);
INSERT INTO order_items (id, order_id, book_id, quantity, price) VALUES (1, 1, 2, 1, 9.99);
INSERT INTO order_items (id, order_id, book_id, quantity, price) VALUES (2, 1, 4, 1, 8.5);
INSERT INTO order_items (id, order_id, book_id, quantity, price) VALUES (3, 1, 5, 8, 18.0);
INSERT INTO order_items (id, order_id, book_id, quantity, price) VALUES (4, 2, 2, 4, 9.99);
INSERT INTO order_items (id, order_id, book_id, quantity, price) VALUES (5, 2, 5, 2, 18.0);
INSERT INTO order_items (id, order_id, book_id, quantity, price) VALUES (6, 2, 1, 1, 29.99);
INSERT INTO order_items (id, order_id, book_id, quantity, price) VALUES (7, 3, 2, 1, 9.99);
INSERT INTO order_items (id, order_id, book_id, quantity, price) VALUES (8, 3, 6, 1, 14.99);

-- Table: orders
CREATE TABLE IF NOT EXISTS orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    total REAL NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO orders (id, username, total, order_date) VALUES (1, 'yurihenrique98', 162.49, '2025-08-07 05:57:26');
INSERT INTO orders (id, username, total, order_date) VALUES (2, 'robert55', 105.95, '2025-08-07 18:36:26');
INSERT INTO orders (id, username, total, order_date) VALUES (3, 'robert55', 24.98, '2025-08-07 18:49:46');

-- Table: users
CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT UNIQUE NOT NULL, password TEXT NOT NULL, role TEXT NOT NULL DEFAULT 'user', email TEXT, phone TEXT, address TEXT, active INTEGER DEFAULT 1);
INSERT INTO users (id, username, password, role, email, phone, address, active) VALUES (3, 'Carol', 'abc456', 'user', NULL, NULL, NULL, 1);
INSERT INTO users (id, username, password, role, email, phone, address, active) VALUES (6, 'testuser123', 'pass123', 'user', NULL, NULL, NULL, 1);
INSERT INTO users (id, username, password, role, email, phone, address, active) VALUES (7, 'admin123', 'admin123', 'admin', NULL, NULL, NULL, 1);
INSERT INTO users (id, username, password, role, email, phone, address, active) VALUES (8, 'robert55', '123456', 'user', 'robert55@gmail.com', NULL, NULL, 1);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
