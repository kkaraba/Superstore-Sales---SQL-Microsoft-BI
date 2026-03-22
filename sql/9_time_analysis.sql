-- Συνολικά Έσοδα - Ποσοστιαία αύξηση - μείωση
with year_sales as(
select year(order_date) as year, 
sum(sales) as sum_sales
from orders_clean
group by year
order by year) 
select 
year as 'Έτος', 
sum_sales as 'Συνολικά Έσοδα',
sum_sales -lag(sum_sales) over (order by year) 'Διαφορά',
round((sum_sales - lag(sum_sales) over (order by year))/lag(sum_sales) over (order by year)*100, 2) as 'Ποσοστιαία Ετήσια αύξηση - μείωση'
from year_sales;

with month_sales as(
select year(order_date) as year, 
month(order_date) as month, 
sum(sales) as sum_sales
from orders_clean
group by year, month
order by year, month) 
select 
year as 'Έτος',
month as 'Μήνας', 
sum_sales as 'Συνολικά Έσοδα',
sum_sales -lag(sum_sales) over (order by year, month) 'Διαφορά',
round((sum_sales - lag(sum_sales) over (order by year, month))/lag(sum_sales) over (order by year, month)*100, 2) as 'Ποσοστιαία Μηνιαία αύξηση - μείωση'
from month_sales;

with sales_region  as (
select 
	c.region,
	year(o.order_date) as year,
	sum(o.sales) as sum_sales
from orders_clean o
left join customers c
on o.customer_id = c.customer_id
group by year(o.order_date), c.region
order by region, year 
)
select 
region as 'Περιοχή',
year as 'Έτος', 
sum_sales as 'Συνολικές Πωλήσεις', 
round((sum_sales - lag(sum_sales) over (partition by region order by year))/lag(sum_sales) over (partition by region order by year)*100, 2) as 'Ποσοστιαία Μεταβολή'
from sales_region;

-- Ετήσιες Πωλήσεις ανά Κατηγορία 
with sales_category as(
select 
	year(o.order_date) as year,
    p.category,
    sum(o.sales) as sum_sales
from orders_clean o 
left join products p 
on o.product_id = p.product_id
group by year, category
order by category,  year)
select 
	year as 'Έτος',
    category as 'Κατηγορία',
    sum_sales as 'Συνολικές Πωλήσεις',
    round((sum_sales - lag(sum_sales) over (partition by category ORDER BY year)) / lag(sum_sales) over (partition by category ORDER BY year) *100,2) as 'Ποσοστιαία Μεταβολή'
from sales_category;

-- Ετήσιες Πωλήσεις ανά Κατηγορία και Υποκατηγορία
select 
	year(o.order_date) as year,
    p.category as 'Κατηγορία',
    p.sub_category 'Υποκατηγορία',
    sum(o.sales) 'Συνολικές Πωλήσεις'
from orders_clean o 
left join products p 
on o.product_id = p.product_id
group by year, category, sub_category
order by category, sub_category, year;
