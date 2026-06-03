-- RetailIQ Business Analysis Project

-- Total Sales KPI
SELECT
    ROUND(SUM(sales), 2) AS total_sales
FROM orders;

-- Total Profit
SELECT
    ROUND(SUM(profit), 2) AS total_profit
FROM orders;

-- Total Orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- Average Order Value
SELECT
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2)
    AS avg_order_value
FROM orders;

-- Top 10 Products by Sales use of join,GROUP BY, ORDER BY, Aggregate Functions
SELECT
    p.product_name,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Top Customers by Revenue
SELECT
    c.customer_name,
    ROUND(SUM(o.sales), 2) AS total_spent
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- Sales by Category
SELECT
    p.category,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- Most Profitable Category
SELECT
    p.category,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_profit DESC;

-- Loss-Making Products
SELECT
    p.product_name,
    ROUND(SUM(o.profit), 2) AS total_loss
FROM orders o
JOIN products p
ON o.product_id = p.product_id
WHERE o.profit < 0
GROUP BY p.product_name
ORDER BY total_loss ASC
LIMIT 10;

-- Highest Selling Sub-Category
SELECT
    p.sub_category,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.sub_category
ORDER BY total_sales DESC;