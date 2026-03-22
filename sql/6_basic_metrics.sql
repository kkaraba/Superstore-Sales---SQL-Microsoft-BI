-- Βασικές Μετρήσεις Συνολικές


select 'Συνολικές Πωλήσεις' as 'Μέτρηση', sum(sales) as 'Τιμή'
from orders_clean
union all
select 'Πωληθέντα Τεμάχια', count(order_id)
from orders_clean
union all
select 'Μέση τιμή τεμαχίου', round(avg(sales), 2)
from orders_clean
union all
select 'Μέση Τιμή Παραγγελίας', round(sum(sales)/count(distinct order_id), 2)
from orders_clean
union all
select 'Διαφορετικά Προϊόντα Πωληθέντα', count(distinct product_id)
from orders_clean
union all
select 'Συνολικές Παραγγελίες', count(distinct order_id)
from orders_clean
union all
select 'Μοναδικοί Πελάτες', count(distinct customer_id)
from orders_clean
