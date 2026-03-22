with rfm as (
select 
	 c.customer_id,
    c.customer_name,
	datediff('2019-01-01', max(o.order_date)) last_order,
    count(order_id) times_ordered,
    sum(o.sales) sum_sales   
from orders_clean o 
left join customers c
on o.customer_id= c.customer_id
group by customer_id, customer_name),
rfm_score as (
select 
	customer_name as 'Όνομα Πελάτη',
    case when last_order <30 then 5
		when last_order <60 then 4
        when last_order <120 then 3
        when last_order <365 then 2
        else 1
        end as recency,
    case when times_ordered > 30 then 5 
		when times_ordered > 20 then 4
        when times_ordered > 10 then 3
        when times_ordered > 5 then 2
        else 1
        end as frequency,
        case when sum_sales >10000 then 5
			when sum_sales >5000 then 4
            when sum_sales >2000 then 3
            when sum_sales >500 then 2
            else 1
            end as monetary
	from rfm
    order by recency desc, frequency desc, monetary desc)
    select *,
		CASE 
    WHEN recency = 5 AND frequency >= 4 AND monetary >= 4 THEN 'Champions'
    WHEN recency >= 4 AND frequency >= 3 THEN 'Loyal'
    WHEN recency = 5 THEN 'Recent'
    WHEN recency <= 2 AND frequency <= 2 AND monetary <= 2 THEN 'At Risk'
    WHEN recency <= 2 THEN 'Hibernating'
    ELSE 'Potential'
END AS segment
    from rfm_score
