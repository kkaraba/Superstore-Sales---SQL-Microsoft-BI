create table orders_clean as 
SELECT 
order_id,
str_to_date(order_date, '%d/%m/%Y') as order_date,
str_to_date(ship_date, '%d/%m/%Y') as ship_date,
ship_mode, 
customer_id,
product_id,
CAST(REPLACE(sales, ',', '.') AS DECIMAL(10,2)) AS sales
FROM orders;
