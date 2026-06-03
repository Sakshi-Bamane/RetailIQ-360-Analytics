-- Verify all tables imported correctly
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM shipping;

-- Null checks

-- Customer
SELECT *
FROM customers
WHERE customer_id IS NULL;

-- Products
SELECT *
FROM products
WHERE product_id IS NULL;

-- Orders
SELECT *
FROM orders
WHERE order_id IS NULL;

-- Shipping
SELECT order_id, COUNT(*)
FROM shipping
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Check Duplicates

-- Customers
SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Products
SELECT product_id, COUNT(*)
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Shipping
SELECT order_id, COUNT(*)
FROM shipping
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Negative profits

-- Orders
SELECT *
FROM orders
WHERE profit < 0;

-- Invalid sales

SELECT *
FROM orders
WHERE sales <= 0;

-- Date inspections

SELECT DISTINCT order_date
FROM orders
LIMIT 20;

DESCRIBE orders;

SELECT *
FROM orders
LIMIT 10;

DROP TABLE orders;
CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    order_date VARCHAR(50),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2)
);

SELECT *
FROM orders
LIMIT 10;

SELECT DISTINCT order_date
FROM orders
LIMIT 20;