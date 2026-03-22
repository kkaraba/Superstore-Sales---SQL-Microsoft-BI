-- επιλέγουμε ΜΙΑ μόνο εμφάνιση του customer_id από τον πίνακα staging_orders κάνοντας group by customer_id
DROP TABLE IF EXISTS customers;
CREATE TABLE customers AS
SELECT 
    customer_id,
    MAX(customer_name) AS customer_name,
    MAX(segment) AS segment,
    MAX(country) AS country,
    MAX(city) AS city,
    MAX(state) AS state,
    MAX(postal_code) AS postal_code,
    MAX(region) AS region
FROM staging_orders
WHERE customer_id IS NOT NULL
GROUP BY customer_id;

-- ορίζουμε και πρωτεύον κλειδί
ALTER TABLE customers ADD PRIMARY KEY (customer_id);

-- επιλέγουμε ΜΙΑ μόνο εμφάνιση του product_id από τον πίνακα staging_orders κάνοντας group by product_id
DROP TABLE IF EXISTS products;
CREATE TABLE products AS
SELECT 
    product_id,
    MAX(product_name) AS product_name,
    MAX(category) AS category,
    MAX(sub_category) AS sub_category
FROM staging_orders
WHERE product_id IS NOT NULL
GROUP BY product_id;

ALTER TABLE products ADD PRIMARY KEY (product_id);

-- δημιουργία πίνακα orders, χρειαζόμαστε ΟΛΕΣ τις εγγραφές
DROP TABLE IF EXISTS orders;
CREATE TABLE orders AS
SELECT 
    order_id,
    order_date,
    ship_date,
    ship_mode,
    product_id,
    customer_id,
    sales
FROM staging_orders
WHERE order_id IS NOT NULL;

-- οι order_id δεν ειναι μοναδικες, σε μια order μπορει να εχω πολλές εγγραφές γιατι κάποιος αγόρασε πολλά πράγματα σε μια παραγγελία
