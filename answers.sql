-- Easy Questions

-- 1. List any 5 records from the orders table.
SELECT * FROM orders LIMIT 5;

--2. Retrieve all ID's where the shipping mode is "Second Class"
SELECT order_id FROM orders WHERE ship_mode = 'Second Class';

--3. TList all records from the orders table where the discount is grater than 20%
select * from orders where discount > 0.2;

-- 4. Find records from the orders table where sales exceed $500
select * from orders where sales > 500;

--5. List all produce names in the "Office Supplies category"
select product_name from products where category = 'Office Supplies';

--6. From the orders table, return all rows of orders placed in 2017
select count(*) from orders where order_date >= '01/01/2017' and order_date <= '12/31/2017';
select count(*) from orders where EXTRACT(YEAR FROM order_date) = 2017;

--7. Find the total sales for each region.  Sort by sales, descending
select SUM(orders.sales) as total_sales, locations.region
from orders
LEFT JOIN locations ON orders.postal_code = locations.postal_code
GROUP BY locations.region
ORDER BY SUM(orders.sales) DESC;

--8. Category Profits - Calculate the total profit for each category.
SELECT SUM(orders.profit) as total_profit, products.category
FROM orders
INNER JOIN products ON products.product_id = orders.product_id
GROUP BY products.category;

-- 9. Shipping Modes - Find the total number of orders for each shipping mode.
Select COUNT(distinct order_id) as total_orders, ship_mode
from orders
GROUP BY ship_mode
ORDER BY total_orders DESC;

-- 10. Subcategory Sales Averages
-- Find the average sales per subcategory, ordered from highest to lowest.
SELECT orders.order_id, products.product_id, products.sub_category, AVG(sales) as avg_sales 
FROM orders
INNER JOIN products ON products.product_id = orders.product_id
GROUP BY products.sub_category
ORDER BY avg_sales DESC;

-- 11. Profit Champions - Find the top 3 orders with the highest profit.  Output order_id and total_profit.
SELECT order_id, SUM(profit) as total_profit
FROM orders
GROUP BY order_id
ORDER BY profit DESC
LIMIT 3;

-- 12. Who's Bringing the Bucks
-- Identify the 5 customers with the highest total sales.  Output customer_id and total_sales
SELECT customer_id, SUM(sales) as total_sales
FROM orders
GROUP BY customer_id 
ORDER BY total_sales DESC
LIMIT 5

-- 13. It's in the Margins!
-- List all records from the orders table where the profit margin exceeds 30%
SELECT (profit / sales) * 100 profit_margin 
FROM ORDERS
WHERE profit_margin > 30
ORDER BY profit_margin DESC

-- 14. Shipping Speedsters
-- Calculate the average delivery time (in days) for each shipping mode
SELECT ship_mode, ship_date, AVG(JULIANDAY(ship_date) - JULIANDAY(order_date)) as delivery_days
FROM orders
GROUP BY ship_mode
ORDER BY delivery_days DESC

-- 15. Subcategory Champions
-- Find the top 2 product subcategories with the highest total sales.  Output sub_category and total_sales
SELECT p.sub_category, SUM(sales) AS total_sales
FROM orders o
LEFT JOIN products p ON p.product_id = o.product_id 
GROUP BY p.sub_category
ORDER BY total_sales DESC
LIMIT 2

-- 16. Annual Sales.  Calculate the total sales for each year, orderd chronologically.
SELECT strftime('%Y', o.order_date ) as order_year, SUM(o.sales) as total_sales
FROM orders o 
GROUP BY order_year
ORDER BY order_year ASC

-- 17. High Discount, High Sales
-- List all records from the orders table where sales exceed $500 and discount is grater than 20%
SELECT o.sales, o.discount 
FROM orders o
WHERE o.sales > 500 AND o.discount > 0.2

-- 18. Central Region
-- Retrieve all order IDs from the Central Region
SELECT DISTINCT(o.order_id)
FROM orders o
LEFT JOIN locations l on l.postal_code = o.postal_code
WHERE l.region = 'Central'


-- 19. 2017 Monthly Sales
-- Calculate total sales for each month in 2017
SELECT SUM(o.sales) as total_sales, STRFTIME('%m', o.order_date) AS sales_month, CAST(STRFTIME('%Y', o.order_date) AS Integer) AS SALES_YEAR
FROM orders o
WHERE SALES_YEAR = 2017
GROUP BY sales_month 
ORDER BY sales_month ASC

-- 20. Shipping Profitibility
-- Return each shipping mode's overall profit margin across all orders.  Round to two decimal places.
SELECT o.ship_mode, ROUND(SUM(o.profit)/SUM(o.sales), 2) AS profit_margin
FROM orders o
GROUP BY o.ship_mode
ORDER BY profit_margin DESC

-- 21. Total Discount
-- Return the total discount amount given across all orders, assuming sales is post-discount
SELECT SUM((o.sales * o.discount)/(1-o.discount)) total_discount
FROM orders o

-- 22. Tables & Chairs
-- List all product names under the "Tables" or "Chairs" subcategories, ordered alphabetically
SELECT  DISTINCT p.product_name
FROM products p 
WHERE p.sub_category IN ("Tables", "Chairs")
ORDER BY p.product_name ASC

-- 23. Big and Bulk Orders
-- List all records from the orders table with profit grater than 500 and quantity greater than 10 units
SELECT *
FROM orders o 
WHERE o.profit > 500 AND o.quantity > 10

-- 24. Lucky Customers
-- How many unique customers received a discount of more than 70% on any product
SELECT COUNT(DISTINCT o.customer_id)
FROM orders o
WHERE o.discount > .7

-- 25. 3000 Profit Club
-- List all orders where total profit exceeded $3000.
-- Output order_id, total_profit (rounded to 2 decimal places, sorted fromt highest to lowest profit)
SELECT o.order_id, ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o
GROUP BY o.order_id
HAVING total_profit > 3000
ORDER BY total_profit DESC


-- 26. First Time to Ten
-- When was the first time more than 10 units of a product were sold in a single order?  Output the order_date
SELECT MIN(o.order_date)
FROM orders o
WHERE o.quantity > 10

-- 27. White Winners
-- List all product names taht contain the word "White"
SELECT DISTINCT p.product_name
FROM products p
WHERE p.product_name LIKE "%white%" OR p.product_name LIKE '%White%'

-- 28. 2015 to 2017
-- Return Return all records from the orders table that were ordered between 2015 and 2017, inclusiv
SELECT *
FROM orders o
WHERE CAST(STRFTIME('%Y', o.order_date) AS Integer)BETWEEN 2015 AND 2017

-- 29. Top 10 Customers
-- Find the top 10 customers by profit.  Output customer_name, total_profit (rounded to 2 decimal places),
-- sorted descending.
SELECT c.customer_name , SUM(ROUND(o.profit, 2)) AS total_profit
FROM orders o
LEFT JOIN customers c ON c.customer_id = o.customer_id 
GROUP BY c.customer_name  
ORDER BY total_profit DESC
LIMIT 10

-- 30. Lost Sales
-- Calculate the total value of sales lost due to returned orders.  Output as lost_sales.
SELECT SUM(o.sales) AS lost_sales
FROM orders o
INNER JOIN returns r ON r.order_id = o.order_id

SELECT SUM(o.sales) AS lost_sales
FROM orders o
LEFT JOIN returns r ON r.order_id = o.order_id
WHERE r.returned IN ('YES', 'yes', 'Yes')

-- 31. Subcategory Distribution
-- Return the number of products in each subcategory, sorted from highest to lowest.
SELECT COUNT(p.sub_category) AS category_count, p.sub_category 
FROM products p
GROUP BY p.sub_category 
ORDER BY category_count DESC

-- 32. Categories and Subcategories
-- List each product category and its corresponding subcategories.  The outputs should contain
-- two columns, category and sub_category, sorted alphabetically
SELECT DISTINCT p.category, p.sub_category 
FROM products p
ORDER BY p.category, p.sub_category ASC

-- 33. Overll Margin
-- Calculate the overall average profit margin percentage, rounded to two decimal places.
-- SELECT  ROUND(AVG((SUM(o.profit) / SUM(o.sales)) * 100), 2) AS avg_profit_margin 
SELECT ROUND(((SUM(o.profit) / SUM(o.sales)) * 100), 2)
FROM orders o

-- 34. Marketing Fuel
-- Superstore's marketing expense has always been 20% of sales.
-- Based on this, calculate the overall marketing costs.
SELECT SUM(o.sales) * 0.20
FROM orders o

-- 35. Segment AOV
-- What is the average order value (AOV) per customer segement?
-- Sort highest to lowest
-- Average Order Value (AOV) is calculated by dividing your total revenue by the total number of orders 
SELECT c.segment, SUM(o.sales) / COUNT(DISTINCT o.order_id)
FROM customers c 
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.segment

-- 36. Lucrative States
-- What are the most profitable states?
SELECT l.state, SUM(o.profit) AS total_profit
FROM locations l
LEFT JOIN orders o ON o.postal_code = l.postal_code
GROUP BY l.state
ORDER BY total_profit DESC

-- 37. Turtle Region
-- Which region has the slowest average delivery time?  Output
-- the region and its average delivery time.
SELECT DISTINCT l.region, JULIANDAY(o.ship_date) - JULIANDAY(o.order_date) AS delivery_time
FROM orders o
LEFT JOIN locations l ON l.postal_code = o.postal_code
ORDER BY delivery_time DESC

-- 38. Peak Season
-- Seasonality-wise, what are the top 3 months with highest sales?
-- Output themonth number and total sales.
SELECT CAST(STRFTIME('%m', o.order_date ) AS Integer) AS month, SUM(o.sales) total_sales
FROM orders o
GROUP BY month
ORDER BY total_sales DESC

-- 39. Lowest Low
-- Which day had the lowest total sales?  If tied, return the earlier date.
SELECT order_date --, STRFTIME('%d', o.order_date) AS sale_day, SUM(o.sales) AS total_sales
FROM orders
GROUP BY order_date
ORDER BY SUM(sales), order_date
LIMIT 1

-- 40. Bestsellers
-- What are the top 5 best selling product?  Output product_name, and total_sales
--SELECT p.product_name AS product_name, SUM(o.profit )
--FROM orders o
--RIGHT JOIN products p ON p.product_id = o.order_id
--GROUP BY product_name
SELECT p.product_name AS product_name, SUM(o.sales) as total_sales
FROM orders o
LEFT JOIN products p ON p.product_id = o.product_id
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5