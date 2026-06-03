-- 1 Monthly Sales Trend
SELECT
    MONTH(
        STR_TO_DATE(order_date, '%Y-%m-%d')
    ) AS month_num,

    ROUND(SUM(sales), 2) AS monthly_sales

FROM orders

GROUP BY month_num
ORDER BY month_num;
-- change date format as it is in varchar -->date
ALTER TABLE orders
MODIFY order_date DATE;
-- describe table
describe orders;

-- 2 Montly Profit trend
SELECT
    MONTH(order_date) AS month_num,

    ROUND(SUM(profit), 2) AS monthly_profit

FROM orders

GROUP BY month_num
ORDER BY month_num;

-- 3 Top 5 Customers Using RANK()

SELECT *
FROM (

    SELECT
        c.customer_name,

        ROUND(SUM(o.sales), 2) AS total_sales,

        RANK() OVER (
            ORDER BY SUM(o.sales) DESC
        ) AS customer_rank

    FROM orders o

    JOIN customers c
    ON o.customer_id = c.customer_id

    GROUP BY c.customer_name

) ranked_customers

WHERE customer_rank <= 5;

-- 4 Top Product in Each Category(partition by -used)

SELECT *
FROM (

    SELECT
        p.category,

        p.product_name,

        ROUND(SUM(o.sales), 2) AS total_sales,

        RANK() OVER (
            PARTITION BY p.category
            ORDER BY SUM(o.sales) DESC
        ) AS product_rank

    FROM orders o

    JOIN products p
    ON o.product_id = p.product_id

    GROUP BY p.category, p.product_name

) ranked_products

WHERE product_rank = 1;

-- 5 Customer segmentation
SELECT
    c.customer_name,

    ROUND(SUM(o.sales), 2) AS total_spent,

    CASE

        WHEN SUM(o.sales) > 10000
            THEN 'High Value'

        WHEN SUM(o.sales) BETWEEN 5000 AND 10000
            THEN 'Medium Value'

        ELSE 'Low Value'

    END AS customer_segment

FROM orders o

JOIN customers c
ON o.customer_id = c.customer_id

GROUP BY c.customer_name

ORDER BY total_spent DESC;

-- 6 Running total sales
SELECT

    order_date,

    sales,

    SUM(sales) OVER (
        ORDER BY order_date
    ) AS running_total_sales

FROM orders;

-- 7 Most frequently ordered products

SELECT

    p.product_name,

    COUNT(o.order_id) AS total_orders

FROM orders o

JOIN products p
ON o.product_id = p.product_id

GROUP BY p.product_name

ORDER BY total_orders DESC

LIMIT 10;

-- 8 Region wise sales analysis
SELECT

    c.region,

    ROUND(SUM(o.sales), 2) AS total_sales

FROM orders o

JOIN customers c
ON o.customer_id = c.customer_id

GROUP BY c.region

ORDER BY total_sales DESC;

-- 9 Profit Margin
SELECT

    ROUND(
        (SUM(profit) / SUM(sales)) * 100,
        2
    ) AS profit_margin_percentage

FROM orders;

-- 10 Average shipping delay

DROP TABLE shipping;
CREATE TABLE shipping (
    order_id VARCHAR(50),
    ship_date DATE,
    ship_mode VARCHAR(100)
);

DESCRIBE shipping;
SELECT *
FROM shipping
LIMIT 10;

SELECT

    AVG(
        DATEDIFF(
            s.ship_date,
            o.order_date
        )
    ) AS avg_shipping_days

FROM orders o

JOIN shipping s
ON o.order_id = s.order_id;