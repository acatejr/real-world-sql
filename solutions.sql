-- SQLite
select SUM(orders.sales) as total_sales, locations.region
from orders
LEFT JOIN locations ON orders.postal_code = locations.postal_code
GROUP BY locations.region
ORDER BY SUM(orders.sales) DESC;
