create Database customer_list;
use customer_list;


select * from olist_customers_dataset;
select * from olist_geolocation_dataset;
select * from olist_order_items_dataset;
select * from olist_order_payments_dataset;
select * from olist_order_reviews_dataset;
select * from olist_customers_dataset;
select * from olist_orders_dataset;
select * from olist_products_dataset;


-- 1. See the first 10 records from each table to explore the data.
SELECT * FROM olist_customers_dataset LIMIT 10;
SELECT * FROM olist_geolocation_dataset LIMIT 10;
SELECT * FROM olist_order_items_dataset LIMIT 10;
SELECT * FROM olist_order_payments_dataset LIMIT 10;
SELECT * FROM olist_order_reviews_dataset LIMIT 10;
SELECT * FROM olist_orders_dataset LIMIT 10;
SELECT * FROM olist_products_dataset LIMIT 10;

-- 2. Total Number of Unique Customers
SELECT COUNT(DISTINCT customer_unique_id) AS total_unique_customers
FROM olist_customers_dataset;


--  3. Number of Orders per State
SELECT c.customer_state, COUNT(o.order_id) AS total_orders
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC ;


-- 4. Top 5 Most Sold Products
SELECT product_id, COUNT(order_id) AS total_sold
FROM olist_order_items_dataset
GROUP BY product_id
ORDER BY total_sold DESC
LIMIT 5;



--  5. Average Payment per Order
SELECT AVG(payment_value) AS avg_payment
FROM olist_order_payments_dataset;





--  6. Total Revenue per Customer
SELECT o.customer_id, round(SUM(p.payment_value),2) AS total_spent
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC;


-- 	7. Top 5 Cities by Number of Customers
SELECT customer_city, COUNT(*) AS total_customers
FROM olist_customers_dataset
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 5;


--  8. Find Orders with No Reviews
SELECT o.order_id
FROM olist_orders_dataset o
LEFT JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
WHERE r.review_id IS NULL;



-- 9.  Orders with Late Delivery
SELECT order_id
FROM olist_orders_dataset
WHERE order_delivered_customer_date > order_estimated_delivery_date;




--  review_category based on review_score using CASE statement.
SELECT 
    order_id,
    review_score,
    CASE 
        WHEN review_score = 5 THEN 'Excellent'
        WHEN review_score = 4 THEN 'Good'
        WHEN review_score = 3 THEN 'Average'
        WHEN review_score = 2 THEN 'Poor'
        WHEN review_score = 1 THEN 'Bad'
        ELSE 'Unknown'
    END AS review_category
FROM olist_order_reviews_dataset
LIMIT 20;


