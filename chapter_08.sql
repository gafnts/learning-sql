-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 08
-- Grouping and aggregates

SELECT customer_id
FROM rental
GROUP BY customer_id;

SELECT customer_id, count(*) total_rentals
FROM rental
GROUP BY customer_id
HAVING total_rentals >= 40
ORDER BY total_rentals DESC;

SELECT
    MAX(amount) max_amt,
    MIN(amount) min_amt,
    AVG(amount) avg_amt,
    SUM(amount) tot_amt,
    COUNT(*) num_payments
FROM payment;

SELECT
    customer_id,
    MAX(amount) max_amt,
    MIN(amount) min_amt,
    AVG(amount) avg_amt,
    SUM(amount) tot_amt,
    COUNT(*) num_payments
FROM payment
GROUP BY customer_id;

SELECT 
    COUNT(customer_id) num_rows,
    COUNT(DISTINCT customer_id) num_customers
FROM payment;

SELECT
    customer_id,
    MAX(datediff(return_date, rental_date)) max_rental
FROM rental
GROUP BY customer_id;

-- How nulls are handled

CREATE TABLE number
    (val SMALLINT);

INSERT INTO number VALUES(1);
INSERT INTO number VALUES(3);
INSERT INTO number VALUES(5);

SELECT 
    COUNT(*) nrows,
    COUNT(val) vals,
    SUM(val) total,
    MAX(val) max,
    AVG(val) avg
FROM number;

INSERT INTO number VALUES(NULL);

SELECT 
    COUNT(*) nrows,
    COUNT(val) vals,
    SUM(val) total,
    MAX(val) max,
    AVG(val) avg
FROM number;

-- Generating groups

-- Single-column grouping

SELECT actor_id, count(*)
FROM film_actor
GROUP BY actor_id;

-- Multicolumn grouping
SELECT fa.actor_id, f.rating, count(*)
FROM film_actor fa INNER JOIN film f USING(film_id)
GROUP BY fa.actor_id, f.rating
ORDER BY 1, 2;

-- Grouping via expressions

SELECT 
    extract(YEAR FROM rental_date) year,
    COUNT(*) how_many
FROM rental
GROUP BY year;

-- Generating rollups

SELECT fa.actor_id, f.rating, count(*)
FROM film_actor fa INNER JOIN film f USING(film_id)
GROUP BY fa.actor_id, f.rating WITH ROLLUP
ORDER BY 1, 2;

-- Group filter condition

SELECT fa.actor_id, f.rating, count(*)
FROM film_actor fa
INNER JOIN film f
ON fa.film_id = f.film_id
WHERE f.rating IN ('G','PG')
GROUP BY fa.actor_id, f.rating
HAVING count(*) > 9;




