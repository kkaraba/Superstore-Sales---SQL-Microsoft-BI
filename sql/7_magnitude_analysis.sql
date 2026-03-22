-- 15 καλύτεροι πελάτες σε σύνολο αγορών
select c.customer_name as 'Όνομα Πελάτη', city as 'Πόλη', segment as 'Τμήμα',  sum(sales) as 'Συνολο Αγορών', count(distinct order_id) as 'Αριθμός Αγορών'
from orders_clean o 
left join customers c
on o.customer_id=c.customer_id
group by c.customer_id, c.customer_name
order by sum(sales) desc
limit 15;

with seg as (select segment , sum(sales) as sum_sales,
count(distinct order_id) as num_orders,
count(order_id) as sold_items
from orders_clean o 
left join customers c
on o.customer_id=c.customer_id
group by segment
order by sum(sales) desc)
select 
segment as 'Τμήμα', 
sum_sales 'Σύνολο Πωλήσεων',
num_orders 'Αριθμός Παραγγελιών',
sold_items 'Αριθμός Πωληθέντων Τεμαχίων',  
round(sum_sales/sum(sum_sales) over () *100, 2) as 'Ποσοστό στις Συνολικές Πωλήσεις'
from seg;


select city as 'Πόλη', sum(sales) as 'Σύνολο Πωλήσεων', count(distinct order_id) as 'Αριθμός Παραγγελιών'
from orders_clean o 
left join customers c
on o.customer_id=c.customer_id
group by city
order by sum(sales) desc
limit 10;

select city as 'Πόλη', sum(sales) as 'Σύνολο Πωλήσεων', count(distinct order_id) as 'Αριθμός Παραγγελιών'
from orders_clean o 
left join customers c
on o.customer_id=c.customer_id
group by city
order by sum(sales) 
limit 10;

with reg as (select region , sum(sales) as sum_sales, count(distinct order_id) as num_orders
from orders_clean o 
left join customers c
on o.customer_id=c.customer_id
group by region
order by sum(sales) desc)
select 
region as 'Τομέας', 
sum_sales as 'Συνολικές Πωλήσεις', 
round (sum_sales/sum(sum_sales) over() *100, 2) as 'Ποσοστό επί των πωλήσεων',
num_orders as 'Αριθμός Παραγγελιών',
round(num_orders/sum(num_orders) over() *100, 2) as 'Ποσοστό επί των παραγγελιών'
from reg;


