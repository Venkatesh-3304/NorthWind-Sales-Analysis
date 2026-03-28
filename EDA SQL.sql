

# EDA Questions

1. What is the average number of orders per customer? Are there high-value repeat customers?

2. How do customer order patterns vary by city or country?

3. Can we cluster customers based on total spend, order count, and preferred categories?

4. Which product categories or products contribute most to order revenue?

5. Are there any correlations between orders and customer location or product category?

6. How frequently do different customer segments place orders?

7. What is the geographic and title-wise distribution of employees?

8. What trends can we observe in hire dates across employee titles?

9. What patterns exist in employee title and courtesy title distributions?

10. Are there correlations between product pricing, stock levels, and sales performance?

11. How does product demand change over months or seasons?

12. Can we identify anomalies in product sales or revenue performance?

13. Are there any regional trends in supplier distribution and pricing?

14. How are suppliers distributed across different product categories?

15. How do supplier pricing and categories relate across different regions?




SELECT 
    ROUND(AVG(order_count), 2) AS avg_orders_per_customer
FROM (
    SELECT 
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) t;



-- Q2: High-Value Repeat Customers

SELECT 
    o.customer_id,
    c.company_name,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_spend
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.company_name
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY total_spend DESC
LIMIT 10;



2. How do customer order patterns vary by city or country?


SELECT 
    c.country,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_orders DESC;

3. Can we cluster customers based on total spend, order count, and preferred categories?

WITH customer_metrics AS (
    SELECT 
        o.customer_id,
        c.company_name,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_spend
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY o.customer_id, c.company_name
)

SELECT *,
    CASE 
        WHEN order_count >= 10 AND total_spend >= 5000 THEN 'High-Value'
        WHEN order_count >= 10 AND total_spend < 5000 THEN 'Frequent'
        WHEN order_count < 10 AND total_spend >= 5000 THEN 'Big Spenders'
        ELSE 'Low-Value'
    END AS customer_segment
FROM customer_metrics
Order by total_spend desc;


4. Which product categories or products contribute most to order revenue?

SELECT 
   
    p.product_name,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

5. Are there any correlations between orders and customer location or product category?


WITH corr AS (
    SELECT 
        customer_id,
        ship_country,
        order_date,
        LEAD(order_date) OVER (
            PARTITION BY customer_id 
            ORDER BY order_date
        ) AS next_order_date,
        
        LEAD(order_date) OVER (
            PARTITION BY customer_id 
            ORDER BY order_date
        ) - order_date AS days_diff

    FROM orders
)



SELECT 
    ship_country,
    ROUND(AVG(days_diff),2) AS avg_days_between_orders
FROM corr
WHERE days_diff IS NOT NULL
GROUP BY ship_country
ORDER BY avg_days_between_orders;


6. How frequently do different customer segments place orders?


WITH customer_metrics AS (
    SELECT 
        o.customer_id,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_spend
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.customer_id
),

customer_segments AS (
    SELECT *,
        CASE 
            WHEN order_count >= 10 AND total_spend >= 5000 THEN 'High-Value'
            WHEN order_count >= 10 AND total_spend < 5000 THEN 'Frequent'
            WHEN order_count < 10 AND total_spend >= 5000 THEN 'Big Spenders'
            ELSE 'Low-Value'
        END AS customer_segment
    FROM customer_metrics
)

SELECT 
    customer_segment,
    SUM(order_count) AS total_orders
FROM customer_segments
GROUP BY customer_segment
ORDER BY total_orders DESC;


7. What is the geographic and title-wise distribution of employees?

SELECT 
    COALESCE(e.city, 'Unknown') AS city,
    e.title,
    COUNT(*) AS employee_count
FROM employees e
GROUP BY city, e.title
ORDER BY city, employee_count DESC;


8. What trends can we observe in hire dates across employee titles?

SELECT 
    EXTRACT(YEAR FROM e.hire_date) AS hire_year,
    e.title,
    COUNT(*) AS employee_count
FROM employees e
GROUP BY hire_year, e.title
ORDER BY hire_year, employee_count DESC;


9.What patterns exist in employee title and courtesy title distributions?


SELECT 
    e.title,
    e.title_of_courtesy,
    COUNT(*) AS employee_count
FROM employees e
GROUP BY e.title, e.title_of_courtesy
ORDER BY employee_count DESC;


10. Are there correlations between product pricing, stock levels, and sales performance?


SELECT 
    p.product_id,
    p.product_name,
    p.unit_price,
    p.units_in_stock,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_revenue
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY 
    p.product_id, 
    p.product_name, 
    p.unit_price, 
    p.units_in_stock;

11. How does product demand change over months or seasons?


SELECT 
    DATE_TRUNC('month', o.order_date)::DATE AS month,
    SUM(od.quantity) AS total_quantity_sold
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY month
ORDER BY month;


12. Can we identify anomalies in product sales or revenue performance?


WITH product_sales AS (
    SELECT 
        p.product_name,
        SUM(od.quantity) AS total_quantity_sold
    FROM products p
    JOIN order_details od ON p.product_id = od.product_id
    GROUP BY p.product_name
),

avg_sales AS (
    SELECT AVG(total_quantity_sold) AS avg_qty
    FROM product_sales
)

SELECT 
    ps.product_name,
    ps.total_quantity_sold,
    a.avg_qty,
    
    CASE 
        WHEN ps.total_quantity_sold > a.avg_qty * 1.5 THEN 'High Anomaly'
        WHEN ps.total_quantity_sold < a.avg_qty * 0.5 THEN 'Low Anomaly'
        ELSE 'Normal'
    END AS anomaly_flag

FROM product_sales ps, avg_sales a
ORDER BY ps.total_quantity_sold DESC;


13.Are there any regional trends in supplier distribution and pricing?

SELECT 
    s.country,
    COUNT(DISTINCT s.supplier_id) AS supplier_count,
    round(AVG(p.unit_price),2) AS avg_product_price
FROM suppliers s
JOIN products p ON s.supplier_id = p.supplier_id
GROUP BY s.country
ORDER BY avg_product_price DESC;

14.How are suppliers distributed across different product categories?

SELECT 
    c.category_name,
    COUNT(DISTINCT s.supplier_id) AS supplier_count
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN suppliers s ON p.supplier_id = s.supplier_id
GROUP BY c.category_name
ORDER BY supplier_count DESC;


15. How do supplier pricing and categories relate across different regions?


SELECT 
    s.country,
    c.category_name,
    round(AVG(p.unit_price),2) AS avg_price
FROM suppliers s
JOIN products p ON s.supplier_id = p.supplier_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY s.country, c.category_name
ORDER BY s.country, avg_price DESC;