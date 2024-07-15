Select * from order_data

-- Total Quantity by year and country for African region

SELECT EXTRACT(YEAR FROM order_date) AS year, country, SUM(quantity) AS total_quantity
FROM order_data
WHERE region = 'Africa'
GROUP BY year, country
ORDER BY year, country

--Total percentage discount by year and African Country

SELECT EXTRACT(YEAR FROM order_date) AS year, country, SUM(discount) AS total_percentage_discount
FROM order_data
WHERE region = 'Africa'
GROUP BY year, country
ORDER BY year, country

--Total Avg. Shipping Cost

SELECT EXTRACT(YEAR FROM order_date) AS year, country, Avg(shipping_cost) AS avg_shipping_cost
FROM order_data
WHERE region = 'Africa'
GROUP BY year, country
ORDER BY year, country

--Total profit by year and country

	
SELECT EXTRACT(YEAR FROM order_date) AS year, country, sum(profit) AS total_profit
FROM order_data
WHERE region = 'Africa'
GROUP BY year, country
ORDER BY year, country

--Profit Margin

SELECT EXTRACT(YEAR FROM order_date) AS year, country, 
SUM(profit) AS total_profit, SUM(sales) AS total_sales, (SUM(profit) / SUM(sales)) * 100 AS profit_margin
FROM order_data
WHERE region = 'Africa'
GROUP BY year, country
ORDER BY year, country

--Countries where the region = Africa

Select EXTRACT(YEAR FROM order_date) AS year, country
From order_data
Where region = 'Africa'
Group BY year, country
Order BY year, country

SELECT country, sum(profit) AS total_profit
From order_data
WHERE EXTRACT(YEAR From order_date) = 2014
AND country = 'Nigeria'
GROUP BY country;


--Average profit by product sub-category made in Nigeria

SELECT sub_category, AVG(profit) AS avg_profit
FROM order_data
WHERE country = 'Nigeria'
GROUP BY sub_category
ORDER BY avg_profit DESC

--Average Profit by product sub-category made in South-east Asia

SELECT sub_category, AVG(profit) AS avg_profit
FROM order_data
WHERE country IN ('Cambodia', 'Indonesia', 'Malaysia', 'Myanmar (Burma)', 'Philippines', 'Singapore', 'Thailand', 'Vietnam')
GROUP BY sub_category
ORDER BY avg_profit DESC

-- I want to know the average profit by sub-category in each countries in south-east asia
	
SELECT country, sub_category, AVG(profit) AS avg_profit
FROM order_data
WHERE country IN ('Cambodia', 'Indonesia', 'Malaysia', 'Myanmar (Burma)', 'Philippines', 'Singapore', 'Thailand', 'Vietnam')
GROUP BY country, sub_category
ORDER BY country, avg_profit DESC

SELECT country, sub_category, SUM(profit) AS total_profit
FROM order_data
WHERE country IN ('Cambodia', 'Indonesia', 'Malaysia', 'Myanmar (Burma)', 'Philippines', 'Singapore', 'Thailand', 'Vietnam')
GROUP BY country, sub_category
ORDER BY country, total_profit DESC

Select * from order_data

--Least profitable in the united states

SELECT city, COUNT(*) AS order_count, AVG(profit) AS avg_profit
FROM order_data
WHERE country = 'United States'
GROUP BY city
HAVING COUNT(*) >= 10
ORDER BY avg_profit ASC

--The average profit by product sub-categories in Lancaster 

SELECT sub_category, AVG(profit) AS avg_profit
FROM order_data
WHERE city = 'Lancaster' AND country = 'United States'
GROUP BY sub_category
ORDER BY avg_profit DESC

--The avg shiiping cost, avg percentage discount, total quantity sold, total sales and profit margin by product sub-categories in Lancaster

SELECT sub_category,
    AVG(shipping_cost) AS avg_shipping_cost,
    AVG(discount) * 100 AS avg_percentage_discount,
    SUM(quantity) AS total_quantity_sold,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin
FROM order_data
WHERE city = 'Lancaster' AND country = 'United States'
GROUP BY sub_category
ORDER BY sub_category;


-- The avg shiiping cost, avg percentage discount, total quantity sold, total sales and profit margin by product sub-categories in Austrialia

SELECT sub_category,
    AVG(shipping_cost) AS avg_shipping_cost,
    AVG(discount) * 100 AS avg_percentage_discount,
    AVG(profit) AS avg_profit,
    SUM(quantity) AS total_quantity_sold,
    SUM(sales) AS total_sales,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin
FROM order_data
WHERE country = 'Australia'
GROUP BY sub_category
ORDER BY sub_category;

--The product name that generated the high profit by appliances

SELECT product_name, 
	AVG(profit) AS avg_profit,
    SUM(profit) AS total_profit
FROM order_data
WHERE sub_category = 'Appliances'
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 1;

--Top 3 most valuable customers

SELECT customer_name, SUM(profit) AS total_profit
FROM order_data
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 3;

--The product the valuable customers purchased that contributed to the total profit.

-- Identify the top 3 customers by total profit

Create table top_customers AS (
    SELECT
        customer_id,
        customer_name,
        SUM(profit) AS total_profit
    FROM order_data
    GROUP BY customer_id, customer_name
    ORDER BY total_profit DESC
    LIMIT 3
)

Select * from top_customers

-- Find the products that contributed to the total profit of these top customers
	
SELECT
    tc.customer_name,
    od.product_name,
    SUM(od.profit) AS total_profit
FROM order_data AS od
JOIN top_customers AS tc
ON od.customer_id = tc.customer_id
GROUP BY tc.customer_name, od.product_name
ORDER BY tc.customer_name, total_profit DESC;












