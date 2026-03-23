# Superstore Sales---SQL, Microsoft BI
Data Analysis project, the data that have been used are Superstore Sales from Kaggle


# Superstore Sales Analytics

## Περιγραφή
Ολοκληρωμένο project ανάλυσης πωλήσεων με dataset 9.800 παραγγελιών.  
Από data cleaning έως business insights και interactive dashboard.
Τα δεδομένα προέρχονται από: 
https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting

## Τεχνολογίες
- **MySQL:** data warehouse, bronze/silver/gold layering
- **Power BI:** interactive dashboard
- **GitHub:** version control & portfolio

## Δομή Βάσης Δεδομένων

### Bronze Layer (Raw Data)
- `staging_orders` – όλα VARCHAR, 9.800 εγγραφές

### Silver Layer (Cleaned Data)
- `customers` – μοναδικοί πελάτες
- `products` – μοναδικά προϊόντα
- `orders_clean` – καθαρές συναλλαγές (με σωστές ημερομηνίες και δεκαδικά)

### Gold Layer (Analytics)
- KPIs
- Customer analytics (top customers, segments, cities, regions)
- Product analytics (top/bottom, categories, subcategories)
- Time analysis (yearly, monthly, MoM)
- RFM segmentation (Champions, Loyal, At Risk, etc.)

## Εκτέλεση
1. Δημιούργησε βάση `superstore_sales`
2. Εκτέλεσε `1_staging_setup.sql`
3. Εκτέλεσε `2_load_data.sql`
4. Εκτέλεσε `3_create_silver_tables.sql`
5. Εκτέλεσε `4_quality_checks.sql`
6. Εκτέλεσε '5_clean_orders.sql'
7. Εκτέλεσε '6_basic_metrics.sql'
8. Εκτέλεσε '7_customer_analysis.sql'
9. Εκτέλεσε '8_product_analysis.sql'
10. Εκτέλεσε '9_time_analysis.sql'
11. Εκτέλεσε '10_rfm_analysis.sql'

## Dashboard
Σελίδες:
- **Overview:** KPIs, time series, categories, regions
- **Customer Analytics:** top customers, RFM segments
- **Product Analytics:** top/bottom products, categories
- **Time Analysis:** monthly and yearly trends
- **RFM - Category/City differences:** RFM distribution, differences, percentages

## Insights
Αναλυτικά ευρήματα και προτάσεις στο `insights.pdf`.

## Επικοινωνία
kkarampasis [at] gmail.com
