USE retailiq;


CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code INT,
    region VARCHAR(50)
);

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    category VARCHAR(100),
    sub_category VARCHAR(100),
    product_name VARCHAR(255)
);

CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    order_date DATE,
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2),

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);

CREATE TABLE shipping (
    order_id VARCHAR(50),
    ship_date DATE,
    ship_mode VARCHAR(100)
);

SELECT *
FROM customers
LIMIT 10;

SELECT *
FROM products
LIMIT 10;
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

DROP TABLE shipping;
CREATE TABLE shipping (
    order_id VARCHAR(50),
    ship_date VARCHAR(50),
    ship_mode VARCHAR(100)
);

SELECT *
FROM shipping
LIMIT 10;














