
-- ==================================================================


-- Section 1: Database Creation
-- Objective: To create a Database for a Nigerian E-commerce Company


-- Short Explanation:
-- This step creates the main database that will contain all project tables and records.


CREATE DATABASE nigeria_ecommerce;

USE nigeria_ecommerce;


-- Result / Insight:
-- A centralized database environment was created.
-- All project tables and insight analysis will be stored inside this database.





-- =====================================================================
-- Section 2: Customer Dimension Table Creation
-- Objective: To store customer-related information.


-- Short Explanation:
-- This table contains customer details such as name, segment,city and region.


CREATE TABLE customer_dim (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    region VARCHAR(50),
    city VARCHAR(100)
);

-- Result / Insight:
-- Customer information was structured for easier business analysis.
-- Each customer has a unique ID.





-- ===================================================================
-- Section 3: Product Dimension Table Creation
-- Objective: To store product information.


-- Short Explanation:
-- This table stores product names and categories.


CREATE TABLE product_dim (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

-- Result / Insight:
-- Products were organized into categories for product performance analysis.





-- ========================================================================
-- Section 4: Date Dimension Table Creation
-- Objective: To organize date-related information for time analysis.


-- Short Explanation:
-- This table stores dates, months, quarters, and years for trend analysis.


CREATE TABLE date_dim (
    order_date DATE PRIMARY KEY,
    order_year INT,
    order_month VARCHAR(20),
    order_month_num INT,
    order_quarter VARCHAR(10)
);


-- Result / Insight:
-- Time-based analysis became easier and more structured.




-- =================================================================
-- Section 5: Orders Fact Table Creation
-- Objective: To store all transaction and sales records.


-- Short Explanation:
-- This is the main business table containing sales, profit, discounts, logistics costs, and order details.


CREATE TABLE order_fact (
    order_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    customer_id VARCHAR(20),
    product_id VARCHAR(20),
    sales_channel VARCHAR(50),
    payment_method VARCHAR(50),
    order_status VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(18,2),
    gross_sales DECIMAL(18,2),
    discount_pct DECIMAL(5,2),
    discount_amount DECIMAL(18,2),
    shipping_fee_charged DECIMAL(18,2),
    logistics_cost DECIMAL(18,2),
    payment_processing_fee DECIMAL(18,2),
    net_sales DECIMAL(18,2),
    cogs DECIMAL(18,2),
    profit DECIMAL(18,2)
);


-- Result / Insight:
-- All transactional business data was successfully centralized.




-- =================================================================
-- Section 6: Data Import
-- Objective: To load CSV datasets into the database.


-- Short Explanation:
-- CSV files were imported into their respective tables.


-- Result / Insight:
-- Data was successfully loaded into the database tables.





-- ===============================================================================
-- Section 7: Data Validation and Quality Checks
-- Objective: To verify the accuracy and completeness of the imported data.


-- Short Explanation: 
-- Checks were performed for row counts, missing values, and duplicate records.


-- Row Count Check

SELECT COUNT(*) FROM orders_fact;
SELECT COUNT(*) FROM dim_customer;
SELECT COUNT(*) FROM dim_product;
SELECT COUNT(*) FROM dim_date;


-- Null Check

SELECT *

FROM 
      orders_fact
WHERE 
      order_date IS NULL
   OR customer_id IS NULL
   OR product_id IS NULL;


-- Duplicate Order Check

SELECT 
     order_id, COUNT(*) AS order_count
FROM 
     orders_fact
GROUP BY 
     order_id
HAVING COUNT(*) > 1;


-- Result / Insight:
-- Data quality issues were identified and validated.
-- The dataset became more reliable for analysis.




-- =============================================================================
-- Section 8: Total Sales Analysis
-- Objective: To calculate total revenue generated from delivered orders.


-- Short Explanation:
-- This query sums all net sales from successfully delivered orders.


SELECT ROUND(SUM(net_sales),2) AS total_net_sales

FROM 
      orders_fact
WHERE 
      order_status = 'Delivered';



-- Result / Insight:
-- Total business revenue was identified.





-- ==========================================================================
-- Section 9: Total Profit Analysis
-- Objective: To determine the company’s total profit.


-- Short Explanation:
-- This query calculates total profit from delivered orders.


SELECT ROUND(SUM(profit),2) AS total_profit

FROM 
      orders_fact
WHERE 
      order_status = 'Delivered';


-- Result / Insight:
-- Overall profitability of the business was measured.




-- ==================================================================
-- Section 10: Total Orders Analysis
-- Objective: To calculate total completed orders.


-- Short Explanation:
-- This query counts all unique delivered orders.


SELECT COUNT(DISTINCT order_id) AS total_orders

FROM 
      orders_fact
WHERE 
      order_status = 'Delivered';


-- Result / Insight:
-- The business order volume was identified.




-- ========================================================================
-- Section 11: Total Customers Analysis
-- Objective: To determine the total number of active customers.


-- Short Explanation:
-- This query counts unique customers with delivered orders.


SELECT COUNT(DISTINCT customer_id) AS total_customers

FROM
      orders_fact
WHERE 
      order_status = 'Delivered';


-- Result / Insight:
-- Customer reach and engagement were measured.




-- =========================================================================
-- Section 12: Average Order Value Analysis
-- Objective: To calculate average revenue generated per order.


-- Short Explanation:
-- This query divides total sales by total delivered orders.


SELECT ROUND(SUM(net_sales) / COUNT(DISTINCT order_id),2) AS avg_order_value

FROM 
       orders_fact
WHERE 
       order_status = 'Delivered';


-- Result / Insight:
-- Average customer spending per order was identified.




-- =========================================================================
-- Section 13: Profit Margin Analysis
-- Objective: To determine business profitability percentage.


-- Short Explanation:
-- This query calculates profit as a percentage of sales.


SELECT ROUND((SUM(profit) / NULLIF(SUM(net_sales),0)) * 100,2) AS profit_margin_pct

FROM 
      orders_fact
WHERE 
      order_status = 'Delivered';



-- Result / Insight:
-- Business efficiency and profitability rate were measured.




-- =====================================================================
-- Section 14: Monthly Sales Trend Analysis
-- Objective: To analyze monthly business performance.



-- Short Explanation:
-- This query tracks sales and profit trends across months and years.


SELECT
    d.order_year,
    d.order_month_num,
    d.order_month,
    ROUND(SUM(o.net_sales),2) AS monthly_sales,
    ROUND(SUM(o.profit),2) AS monthly_profit

FROM 
    orders_fact o
JOIN 
    dim_date d
ON 
    o.order_date = d.order_date
WHERE
    o.order_status = 'Delivered'
GROUP BY
    d.order_year, d.order_month_num, d.order_month
ORDER BY
    d.order_year, d.order_month_num;



-- Result / Insight:
-- Seasonal trends and high-performing months were identified.




-- ======================================================================
-- Section 15: Category Performance Analysis
-- Objective: To identify the best-performing product categories.



-- Short Explanation:
-- This query compares categories based on sales, profit, and units sold.


SELECT
    p.category,
    ROUND(SUM(o.net_sales),2) AS total_sales,
    ROUND(SUM(o.profit),2) AS total_profit,
    SUM(o.quantity) AS total_units

FROM 
    orders_fact o
JOIN 
    dim_product p
ON 
    o.product_id = p.product_id
WHERE 
    o.order_status = 'Delivered'
GROUP BY
    p.category
ORDER BY 
    total_sales DESC;



-- Result / Insight:
-- The highest-performing product categories were identified.





-- =========================================================================
-- Section 16: Top 10 Products by Revenue
-- Objective: To identify the highest revenue-generating products.



-- Short Explanation:
-- This query ranks products based on total sales revenue.


SELECT
    p.product_name,
    ROUND(SUM(o.net_sales),2) AS total_sales,
    ROUND(SUM(o.profit),2) AS total_profit,
    SUM(o.quantity) AS units_sold

FROM
    orders_fact o
JOIN 
    dim_product p
ON 
    o.product_id = p.product_id
WHERE
    o.order_status = 'Delivered'
GROUP BY
    p.product_name
ORDER BY
    total_sales DESC;



-- Result / Insight:
-- Top-selling products were identified.




-- =================================================================
-- Section 17: Top 10 Products by Profit
-- Objective: To identify the most profitable products.


-- Short Explanation:
-- This query ranks products based on profit generated.


SELECT
    p.product_name,
    ROUND(SUM(o.profit),2) AS total_profit,
    ROUND(SUM(o.net_sales),2) AS total_sales

FROM 
    orders_fact o
JOIN 
    dim_product p
ON 
    o.product_id = p.product_id
WHERE 
    o.order_status = 'Delivered'
GROUP BY 
    p.product_name
ORDER BY
    total_profit DESC;



-- Result / Insight:
-- High-profit products were identified.





-- ===================================================================
-- Section 18: Customer Performance Analysis
-- Objective: To evaluate customer purchasing behavior.


-- Short Explanation:
-- This query analyzes customer sales, profit contribution, and order count.


SELECT
    c.customer_name,
    c.segment,
    ROUND(SUM(o.net_sales),2) AS customer_sales,
    ROUND(SUM(o.profit),2) AS customer_profit,
    COUNT(DISTINCT o.order_id) AS order_count

FROM 
     orders_fact o
JOIN 
     dim_customer c
ON
     o.customer_id = c.customer_id
WHERE
     o.order_status = 'Delivered'
GROUP BY
     c.customer_name, c.segment
ORDER BY
     customer_sales DESC;



-- Result / Insight:
-- High-value customers were identified.




-- ==================================================================
-- Section 19: Segment Performance Analysis
-- Objective: To compare customer segments.



-- Short Explanation:
-- This query evaluates each customer segment based on sales and profit.


SELECT
    c.segment,
    ROUND(SUM(o.net_sales),2) AS total_sales,
    ROUND(SUM(o.profit),2) AS total_profit,
    COUNT(DISTINCT o.customer_id) AS customers

FROM
    orders_fact o
JOIN 
    dim_customer c
ON 
    o.customer_id = c.customer_id
WHERE
    o.order_status = 'Delivered'
GROUP BY
    c.segment
ORDER BY
    total_sales DESC;



-- Result / Insight:
-- The most valuable customer segment was identified.




-- =================================================================
-- Section 20: Regional Performance Analysis
-- Objective: To analyze business performance across regions.



-- Short Explanation
-- This query compares regional sales, profit, and order volume.


SELECT
    c.region,
    ROUND(SUM(o.net_sales),2) AS total_sales,
    ROUND(SUM(o.profit),2) AS total_profit,
    COUNT(DISTINCT o.order_id) AS total_orders

FROM 
    orders_fact o
JOIN 
    dim_customer c
ON
    o.customer_id = c.customer_id
WHERE
    o.order_status = 'Delivered'
GROUP BY
    c.region
ORDER BY
    total_sales DESC;


-- Result / Insight:
-- Strongest and weakest regions were identified.




-- ===========================================================
-- Section 21: City Performance Analysis
-- Objective: To analyze city-level sales performance.



-- Short Explanation:
--This query compares sales and profit across cities.


SELECT
    c.city,
    ROUND(SUM(o.net_sales),2) AS total_sales,
    ROUND(SUM(o.profit),2) AS total_profit

FROM 
    orders_fact o
JOIN
    dim_customer c
ON
    o.customer_id = c.customer_id
WHERE
    o.order_status = 'Delivered'
GROUP BY
    c.city
ORDER BY
    total_sales DESC;



-- Result / Insight:
-- Best-performing cities were identified.




-- ===============================================================
-- Section 22: Discount Impact Analysis
-- Objective: To analyze how discounts affect profitability.



-- Short Explanation:
-- This query groups orders into discount levels and compares sales and profit.


SELECT
    CASE
        WHEN discount_pct = 0 THEN 'No Discount'
        WHEN discount_pct > 0 AND discount_pct <= 0.10 THEN 'Low Discount'
        WHEN discount_pct > 0.10 AND discount_pct <= 0.20 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_band,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(net_sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(profit),2) AS avg_profit_per_order
FROM 
    orders_fact
WHERE 
    order_status = 'Delivered'
GROUP BY
    CASE
        WHEN discount_pct = 0 THEN 'No Discount'
        WHEN discount_pct > 0 AND discount_pct <= 0.10 THEN 'Low Discount'
        WHEN discount_pct > 0.10 AND discount_pct <= 0.20 THEN 'Medium Discount'
        ELSE 'High Discount'
    END
ORDER BY 
    total_sales DESC;



-- Result / Insight:
-- The relationship between discounts and profitability was identified.




-- =====================================================================
-- Section 23: Logistics Impact Analysis
-- Objective: To evaluate logistics costs across regions.



-- Short Explanation:
-- This query compares logistics cost, shipping fee, and profit by region.


SELECT
    c.region,
    ROUND(AVG(o.logistics_cost),2) AS avg_logistics_cost,
    ROUND(AVG(o.shipping_fee_charged),2) AS avg_shipping_fee,
    ROUND(SUM(o.profit),2) AS total_profit
FROM 
    orders_fact o
JOIN 
    dim_customer c
ON 
    o.customer_id = c.customer_id
WHERE
    o.order_status = 'Delivered'
GROUP BY 
    c.region
ORDER BY
    avg_logistics_cost DESC;



-- Result / Insight:
-- Regions with high logistics expenses were identified.




-- ==================================================================
-- Section 24: Delivery Lag Analysis
-- Objective: To measure delivery efficiency.



-- Short Explanation:
-- This query calculates the average delivery time for each region.


SELECT
    c.region,
    ROUND(AVG(DATEDIFF(DAY, o.order_date, o.ship_date)),2) AS avg_delivery_days
FROM 
    orders_fact o
JOIN 
    dim_customer c
ON
    o.customer_id = c.customer_id
WHERE 
    o.order_status = 'Delivered'
GROUP BY
    c.region
ORDER BY
    avg_delivery_days DESC;



-- Result / Insight:
-- Delivery delays and efficient regions were identified.





-- =======================================================================
-- Section 25: Returned and Cancelled Order Analysis
-- Objective: To evaluate the impact of unsuccessful orders.



-- Short Explanation:
-- This query analyzes cancelled, returned, and delivered orders.


SELECT
    order_status,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(net_sales),2) AS affected_sales
FROM 
    orders_fact
GROUP BY
    order_status
ORDER BY
    orders DESC;


-- Result / Insight:
-- Cancelled and returned orders negatively affected revenue.




-- ===================================================================
-- Section 26: Sales Channel Performance Analysis
-- Objective: To identify the best-performing sales channels.



-- Short Explanation:
-- This query compares channels based on sales, profit, and orders.


SELECT
    sales_channel,
    ROUND(SUM(net_sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    orders_fact
WHERE 
    order_status = 'Delivered'
GROUP BY
    sales_channel
ORDER BY
total_sales DESC;



-- Result / Insight:
-- The most effective sales channels were identified.




-- =================================================================
-- Section 27: SQL View Creation for Power BI (Sales Summary View)
-- Objective: To create a centralized SQL view that simplifies data analysis and connects directly to Power BI.




-- Short Explanation:
-- This view combines all major tables (orders, customers, products, and dates) into one clean dataset for reporting and dashboard building in Power BI.



CREATE VIEW sales_summary_view AS
SELECT

    o.order_id,
    o.customer_id,
    o.order_date,
    d.order_year,
    d.order_month,
    d.order_month_num,
    d.order_quarter,
    c.customer_name,
    c.segment,
    c.region,
    c.city,
    p.product_name,
    p.category,
    o.sales_channel,
    o.payment_method,
    o.order_status,
    o.quantity,
    o.net_sales,
    o.discount_amount,
    o.logistics_cost,
    o.profit
FROM 
    orders_fact o
JOIN 
    dim_customer c
ON 
    o.customer_id = c.customer_id
JOIN
    dim_product p
ON
    o.product_id = p.product_id
JOIN 
    dim_date d
ON
    o.order_date = d.order_date;



-- Result / Insight:
-- A unified dataset was created from multiple tables.
-- All key business fields are now available in one view.
-- Power BI can connect directly without complex joins.


-- ===========================================================



ALTER VIEW sales_summary_view AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.ship_date,
    d.order_year,
    d.order_month,
    d.order_month_num,
    d.order_quarter,
    c.customer_name,
    c.segment,
    c.region,
    c.city,
    p.product_name,
    p.category,
    o.sales_channel,
    o.payment_method,
    o.order_status,
    o.quantity,
    o.net_sales,
    o.discount_amount,
    o.logistics_cost,
    o.profit
FROM 
    orders_fact o
JOIN 
    dim_customer c
ON 
    o.customer_id = c.customer_id
JOIN 
    dim_product p
ON 
    o.product_id = p.product_id
JOIN
    dim_date d
ON 
    o.order_date = d.order_date;


-- ==============================================================