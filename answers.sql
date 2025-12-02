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

--7. Find the total sales for each region.  Sory by sales, descending
select SUM(orders.sales) as total_sales, locations.region
from orders
LEFT JOIN locations ON orders.postal_code = locations.postal_code
GROUP BY locations.region
ORDER BY SUM(orders.sales) DESC;

-- SELECT product_id, product_name, category_name
-- FROM products
-- INNER JOIN categories ON products.category_id = categories.category_id; 