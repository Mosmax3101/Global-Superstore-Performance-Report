--ABUDU HALIMAT OLUWABUKOLA
--Graduation Project
-- Topic: Global Superstore Analysis

-- The first question is;
-- a) What are the three countries that generated the highest total profit for Global Superstore in 2014?
--b) For each of these three countries, find the three products with the highest total profit.
--Specifically, what are the products’ names and the total profit for each product?

--Steps;
-- Select country from order_data
--Sum all the profit and name it as TOTAL PROFIT
--Then extract year '2014' from the date column
--Limit to 3
--Group by country name and product name
--order by product name and total profit

Select * from order_data

SELECT country, sum(profit) AS Total_Profit
FROM order_data
WHERE Extract(year from order_date) = 2014
GROUP BY country
ORDER BY Total_Profit DESC
LIMIT 3;

--The top 3 countries with the highest profit is united states, india and china
-- The next step is to find the three products for each of the top 3 countries that generated the highest profit.

SELECT country, product_name, sum(profit) AS Total_Profit
FROM order_data
WHERE EXTRACT(year FROM order_date) = 2014 AND country IN ('United States')
GROUP BY country, product_name
ORDER BY country, Total_Profit DESC
Limit 3;

--Top 3 products with the highest profit in China

SELECT country, product_name, sum(profit) AS Total_Profit
FROM order_data
WHERE EXTRACT(year FROM order_date) = 2014 AND country IN ('China')
GROUP BY country, product_name
ORDER BY country, Total_Profit DESC
Limit 3;

--Top 3 products with the highest profit in India

SELECT country, product_name, sum(profit) AS Total_Profit
FROM order_data
WHERE EXTRACT(year FROM order_date) = 2014 AND country IN ('India')
GROUP BY country, product_name
ORDER BY country, Total_Profit DESC
Limit 3;

-- Well we have solved the first question so now onto the next analytical question;

-- Identify the 3 subcategories with the highest average shipping cost in the United States.
-- The first step is to select sub-category column and then the average of the shipping cost and
-- Filter country = united states then group it by the sub-category and limit it to 3.

Select sub_category, avg(shipping_cost) as Avg_Shipping_Cost
From order_data
Where country = 'United States'
Group by sub_category
Order by Avg_Shipping_Cost Desc
Limit 3;

--Now we going deeper with the questions by comparing countries profit.
-- a) Assess Nigeria's profitability (i.e., total profit) for 2014. How does it compare to other
--African countries?
-- b) What factors might be responsible for Nigeria's poor performance? You might want to
--investigate shipping costs and the average discount as potential root causes.

-- The first step is to solve the first question; To do that we need to know the total profit
-- Nigeria made for 2014.
-- Then after that we need to compare the profit with the other african countries.
-- I will be using the sum, where & and, group by syntax to achieve the desired results.



SELECT country, sum(profit) AS total_profit
From order_data
WHERE EXTRACT(YEAR From order_date) = 2014
AND country = 'Nigeria'
GROUP BY country;

--After running this query it shows that Nigeria is making a Loss of 23,285.32 for 2014 
-- This shows a poor performance but we need to compare it with other African Countries

Select * from order_data

Select country, Sum(profit) AS total_profit
From order_data
WHERE EXTRACT(YEAR FROM order_date) = 2014
And region = 'Africa'
GROUP BY country
ORDER by total_profit DESC;

-- Based on the result, it shows that Nigeria is performing the least compared to other african countries
-- Now we need to invetigate the reason for the poor performance, The indication is to assess
-- the shipping cost and the discount rate given by the African Countries.

Select country, AVG(shipping_cost) AS avg_shipping_cost
From order_data
WHERE EXTRACT(YEAR FROM ship_date) = 2014
And region = 'Africa'
GROUP by country
ORDER by avg_shipping_cost DESC;

-- Based on the result Nigeria made a loss because it wasn't importing goods and spending on the shipping fee.
-- Now we need to know the avg discount rate given by each African Countries.

Select country, AVG(discount) AS avg_discount
From order_data
WHERE EXTRACT(YEAR FROM order_date) = 2014
And region = 'Africa'
GROUP by country
ORDER by avg_discount DESC;

-- Now moving on with ou analysis, the next question is;
-- a) Identify the product subcategory that is the least profitable in Southeast Asia.
-- Note: For this question, assume that Southeast Asia comprises Cambodia,
--Indonesia, Malaysia, Myanmar (Burma), the Philippines, Singapore, Thailand, and Vietnam.
-- b) Is there a specific country in Southeast Asia where Global Superstore should stop
-- offering the subcategory identified in 4a?

-- For the first question we need to select the subcategory by the southeast asia in the mentioned countries above and 
-- get the total profit for this region for each sub-category

Select sub_category, sum(profit) AS total_profit
From order_data
Where country IN ('Cambodia', 'Indonesia', 'Malaysia', 'Myanmar (Burma)', 'Philippines', 'Singapore', 'Thailand', 'Vietnam')
Group by sub_category
Order by total_profit ASC
LIMIT 1;



-- The least profitable sub-category in the southeastern asia in the selected area is Tables with the Loss of 18,618.

-- We need identify the countries in the southeastern asia where the production and distribution of tables has to be stopped.

SELECT country, Sum(profit) AS total_profit
From order_data
Where sub_category = 'Tables'
AND country IN ('Cambodia', 'Indonesia', 'Malaysia', 'Myanmar (Burma)', 'Philippines', 'Singapore', 'Thailand', 'Vietnam')
GROUP BY country
ORDER BY total_profit ASC
LIMIT 1;

-- Based on the result Indonesia in the Southeastern Asia made the least profit for the sub-category Tables
-- The Global Superstore should discontinue this sub_category in Indonesia to prevent future losses and negative cashflows 
-- And focus on the countries that is generating positive cashflow to the store

-- Question 5.
-- a) Which city is the least profitable (in terms of average profit) in the United States? For
-- this analysis, discard the cities with less than 10 Orders.
-- b) Why is this city's average profit so low?
-- To answer this question the first step now is to filter out the order in the united states
-- Then calculate the average profits by orders for each cities and filter out those 
--orders greater than 10 only.

select * from order_data

Select city, COUNT(*) AS order_count, AVG(profit) AS avg_profit 
From order_data
WHERE country = 'United States'
GROUP BY city
HAVING COUNT(*) >= 10

-- The next step is to determine the city that makes the lowest avg_profit

SELECT city, COUNT(*) AS order_count, AVG(profit) AS avg_profit
FROM order_data
WHERE country = 'United States'
GROUP BY city
HAVING COUNT(*) >= 10
ORDER BY avg_profit ASC
LIMIT 1;

-- From the result gotten below we found out that Lancaster has the lowest avg_profit with 46 orders
-- We need to investigate why the profit in this city is low.
-- So our next step is to analyze the reason for the low profit.
-- To analyze this result we need to know the factors that wil contribute to the loss.
-- We could find out how much this city is spending on their shipping and if discount is being given
-- to customers to boost quantities in turn boost sales and profit.

SELECT AVG(shipping_cost) AS avg_shipping_cost
FROM order_data
WHERE city = 'Lancaster'

-- So the avg shipping cost for Lancaster is 23.99 but I want to compare this result with other countries

SELECT country, AVG(shipping_cost) AS avg_shipping_cost
FROM order_data
WHERE country = 'United States' 
GROUP BY country
HAVING COUNT(*) >= 10

SELECT AVG(discount) AS avg_discount
FROM order_data
WHERE city = 'Lancaster'

-- Question 6.
--a) Which product subcategory has the highest average profit in Australia?


SELECT sub_Category, AVG(profit) AS avg_profit
FROM order_data
WHERE country = 'Australia'
GROUP BY sub_category
ORDER BY avg_profit DESC
LIMIT 1;

--Question 7.
-- a) Which customer returned items and what segment do they belong
-- b) Who are the most valuable customers and what do they purchase?
-- 	To answer this question we need to select from the customer and segment and 
-- filter out the returned goods.

SELECT * FROM order_data

SELECT * FROM store_returns


SELECT od.customer_name, od.segment, sr.returned, sr.market
FROM order_data AS od
LEFT JOIN store_returns AS sr
ON od.order_id = sr.order_id
WHERE sr.returned = 'Yes'

-- The next question is to determine the most valuable customers
-- We need to find out the top 10 customers per total profit
    
SELECT customer_name, SUM(profit) AS total_profit
FROM order_data
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 10; 

--We have come to the end of the analysis/ performance of the global superstore
-- Follow me for the visualization and how i use DAX Expressions in PowerBI to achieve the KPI and charts 












