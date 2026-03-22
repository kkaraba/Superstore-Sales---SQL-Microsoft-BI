-- top 15 προϊόντα σε όρους πωλήσεων - εσόδων
select p.product_id, p.product_name, p.category, sum(o.sales) as 'Σύνολο Εσόδων', count(distinct order_id) as 'Αριθμός Πωλήσεων'
from orders_clean o 
left join products p
on o.product_id = p.product_id
group by p.product_id, p.product_name
order by sum(o.sales) desc
limit 15;

-- bottom 15 προϊόντα σε όρους πωλήσεων - εσόδων
select p.product_id, p.product_name, p.category, sum(o.sales) as 'Σύνολο Εσόδων', count(distinct order_id) as 'Αριθμός Πωλήσεων'
from orders_clean o 
left join products p
on o.product_id = p.product_id
group by p.product_id, p.product_name
order by sum(o.sales) 
limit 15;

-- top 15 προϊόντα σε αριθμό πωλήσεων
select p.product_id, p.product_name, p.category, sum(o.sales) as 'Σύνολο Εσόδων', count(distinct order_id) as 'Αριθμός Πωλήσεων'
from orders_clean o 
left join products p
on o.product_id = p.product_id
group by p.product_id, p.product_name
order by count(distinct order_id) desc
limit 15;

-- κατηγορίες προϊόντων - πωλήσεις
select p.category, sum(sales) 'Σύνολο Εσόδων', count(order_id) 'Αριθμός Πωλήσεων'
from orders_clean o 
left join products p
on o.product_id = p.product_id
group by p.category
order by sum(sales) desc;

with cat_sub as (select p.category as category, p.sub_category as sub_category, sum(sales) sum_rev, count(order_id) num_orders
from orders_clean o 
left join products p
on o.product_id = p.product_id
group by p.category, p.sub_category
order by category, sum(sales) desc)
select category as 'Κατηγορία',
sub_category as 'Υποκατηγορία', 
sum_rev as 'Συνολικά Έσοδα',
round(sum_rev / sum(sum_rev) over (partition by category) * 100, 2) as 'Ποσοστό πωλήσεων υποκατηγορίας επί της κατηγορίας',
num_orders as 'Αριθμός Πωληθέντων',
round(num_orders / sum(num_orders) over (partition by category) * 100, 2) as 'Ποσοστό αριθμού πωληθέντων υποκατηγορίας επί της κατηγορίας'
from cat_sub
order by category;

select *
from orders_clean o 
left join products p
on o.product_id = p.product_id;

-- 5% των προϊόντων με τις λιγότερες εισπράξεις
with sal as (select p.product_id, product_name, sum(sales) as sum_sales
from orders_clean o 
left join products p
on o.product_id = p.product_id
group by p.product_id, product_name
order by sum(sales) desc),
part as (select product_name, sum_sales,
ntile(20) over (partition by sum_sales) as parts
from sal)
select *
from part
where parts=1
