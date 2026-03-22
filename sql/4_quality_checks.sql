-- ΕΛΕΓΧΟΣ toy customers
-- έλεγχος διπλότυπων customer_id
select count(customer_id) c
from customers
group by customer_id
having c>1;

-- έλεγχος για κενά
select *
from customers
where customer_name != trim(customer_name);

select *
from customers
where segment != trim(segment);

-- ελεγχος για διαφορετικό τροπο γραφης π.χ. United States, USA
select distinct country
from customers;

select  city
from customers
where city != trim(city);

-- έλεγχος για παρόμοια γραφή states
select distinct state
from customers
order by state;

select state
from customers
where state != trim(state);

-- εύρος τιμών Τ.Κ. πιθανά λάθη...
select max(postal_code), min(postal_code)
from customers;

select distinct region
from customers;

select *
from customers
where region !=trim(region);

-- -------------------------------------------------------------------------------
-- ΕΛΕΓΧΟΣ του products
-- έλεγχος για τιμές null
select *
from products
where product_id is null or product_name is null or category is null or sub_category is null;

-- διπλότυπα product_id
select count(product_id) c
from products
group by product_id
having c>1;

select *
from products
where product_name != trim(product_name);

-- διαφορετικές κατηγορίες - περίπου ίδια γραφή..
select distinct category
from products;

select distinct sub_category
from products
order by sub_category;

-- συνδυασμοί κατηγορίας - υποκατηγορίας
select distinct category, sub_category
from products
order by  category, sub_category; 
-- έλεγχος αν υπάρχουν product_name που δεν ταιριάζουν με category
-- π.χ. "Bush Somerset Collection Bookcase" να είναι στην κατηγορία "Furniture"
SELECT product_name, category, sub_category 
FROM products 
WHERE (category = 'Furniture' AND sub_category NOT IN ('Bookcases', 'Chairs', 'Furnishings', 'Tables'))
   OR (category = 'Technology' AND sub_category NOT IN ('Accessories', 'Copiers', 'Machines', 'Phones'))
   OR (category = 'Office Supplies' AND sub_category NOT IN ('Appliances', 'Art', 'Binders', 'Envelopes', 'Fasteners', 'Labels', 'Paper', 'Storage', 'Supplies'));

-- -----------------------------------------------------------------------------------------
-- ΕΛΕΓΧΟΣ του orders
SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'orders' AND COLUMN_NAME = 'order_date';

SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'superstore_sales'   -- βάλε το όνομα της βάσης σου
  AND TABLE_NAME = 'orders' 
  AND COLUMN_NAME = 'order_date';
  
  SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'superstore_sales'   -- βάλε το όνομα της βάσης σου
  AND TABLE_NAME = 'orders' 
  AND COLUMN_NAME = 'ship_date';
  
  select *
  from orders
  where order_date != trim(order_date);
  
  select *
  from orders
  where ship_date != trim(ship_date);
  
  -- Καταλαβαίνω ότι πρέπει να αλλάξει ο τύπος δεδομένων των στηλών order_date και ship_date
  
  SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'superstore_sales'   -- βάλε το όνομα της βάσης σου
  AND TABLE_NAME = 'orders' 
  AND COLUMN_NAME = 'sales';
  -- πρεπει να αλλάξει και ο τυπος δεδομενων της sales (ειναι varchar) σε decimal




