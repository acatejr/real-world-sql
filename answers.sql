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