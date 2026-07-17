-- =====================================================================
-- Script Name: ecommerce_analysis.sql
-- Author: Ankita Shinde
-- Role: Data Analyst Intern (DataX Labs)
-- Description: MySQL database initialization, transactional data 
--              injection, and advanced relational analytical queries.
-- =====================================================================

-- Create and initialize schema sandbox safely
CREATE DATABASE IF NOT EXISTS datax_ecommerce_db;
USE datax_ecommerce_db;

-- 1. SCHEMA INITIALIZATION (Enforcing strict constraint metrics)
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    join_date DATE NOT NULL
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    CONSTRAINT fk_orders_users FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE order_details (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT fk_details_orders FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_details_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 2. HIGH-INTEGRITY MOCK DATA SEEDING
INSERT INTO users (name, email, join_date) VALUES 
('Ankita Shinde', 'ankita@example.com', '2026-01-15'),
('Rahul Sharma', 'rahul@example.com', '2026-02-10'),
('Priya Patel', 'priya@example.com', '2026-02-22'),
('Amit Mishra', 'amit@example.com', '2026-03-01'),
('Sneha Reddy', 'sneha@example.com', '2026-03-12');

INSERT INTO products (product_name, category, price) VALUES 
('Wireless Mouse', 'Electronics', 25.00),
('Mechanical Keyboard', 'Electronics', 85.00),
('Ergonomic Chair', 'Furniture', 250.00),
('Coffee Mug', 'Kitchen', 15.00),
('Water Bottle', 'Kitchen', 20.00);

INSERT INTO orders (user_id, order_date, status) VALUES 
(1, '2026-06-01', 'Completed'),
(2, '2026-06-02', 'Completed'),
(1, '2026-06-15', 'Completed'),
(3, '2026-06-18', 'Pending'),
(4, '2026-06-20', 'Completed'),
(NULL, '2026-06-22', 'Shipped'); 

INSERT INTO order_details (order_id, product_id, quantity) VALUES 
(1, 1, 2), 
(1, 4, 1), 
(2, 2, 1), 
(3, 3, 1), 
(4, 5, 3), 
(5, 1, 1);

-- 3. INTERNSHIP SPECIFIC CORE DELIVERABLE QUERIES

-- Query A: Multi-Table INNER JOIN + Aggregations (Revenue by Category)
SELECT 
    p.category AS Product_Category,
    SUM(od.quantity) AS Total_Units_Sold,
    SUM(od.quantity * p.price) AS Gross_Revenue
FROM order_details od
INNER JOIN products p ON od.product_id = p.product_id
GROUP BY p.category
ORDER BY Gross_Revenue DESC;

-- Query B: LEFT JOIN validating NULL data-mapping filters
SELECT 
    o.order_id,
    o.order_date,
    COALESCE(u.name, 'Guest Customer') AS Customer_Identity
FROM orders o
LEFT JOIN users u ON o.user_id = u.user_id;

-- Query C: Subquery isolating premium above-average transactions
SELECT order_id, product_id, quantity
FROM order_details
WHERE (quantity * (SELECT price FROM products WHERE products.product_id = order_details.product_id)) > (
    SELECT AVG(od.quantity * p.price) 
    FROM order_details od 
    JOIN products p ON od.product_id = p.product_id
);

-- Query D: Average Revenue Per User (ARPU Calculation)
SELECT 
    COUNT(DISTINCT o.user_id) AS Active_Users,
    SUM(od.quantity * p.price) AS Total_Revenue,
    ROUND(SUM(od.quantity * p.price) / COUNT(DISTINCT o.user_id), 2) AS ARPU
FROM order_details od
JOIN products p ON od.product_id = p.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE o.user_id IS NOT NULL;

-- 4. VIEW LOG DEFINITION FOR EXECUTIVE REPORTING LAYER
CREATE OR REPLACE VIEW view_executive_sales_summary AS
SELECT 
    u.user_id,
    u.name AS Customer_Name,
    COUNT(DISTINCT o.order_id) AS Total_Orders,
    SUM(od.quantity * p.price) AS Total_Spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id;

-- Test View Output Verification
SELECT * FROM view_executive_sales_summary;

-- 5. STRUCTURAL DATABASE INDICES FOR OPTIMIZATION
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_order_details_order_id ON order_details(order_id);
