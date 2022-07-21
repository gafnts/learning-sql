-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 04

-- Condition types

-- Equality condition
SELECT c.email
FROM customer c
    INNER JOIN rental r
    ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14';

-- Inequality conditions
SELECT c.email
FROM customer c
    INNER JOIN rental r
    ON c.customer_id = r.customer_id
WHERE date(r.rental_date) != '2005-06-14';

-- Data modification using equality conditions
DELETE FROM rental
WHERE year(rental_date) = 2004;

-- Range conditions
SELECT customer_id, rental_date
FROM rental
WHERE rental_date <= '2005-06-16'
    AND rental_date >= '2005-06-14';

-- The between operator
SELECT customer_id, rental_date
FROM rental
WHERE rental_date BETWEEN '2005-06-14' AND '2005-06-16';

SELECT customer_id, payment_date, amount
FROM payment
WHERE amount BETWEEN 10 AND 11.99;

-- String ranges
SELECT first_name, last_name
FROM customer
WHERE last_name BETWEEN 'FA' AND 'FRB';

-- Membership conditions
SELECT title, rating
FROM film
WHERE rating = 'G' OR rating = 'PG';

SELECT title, rating
FROM film
WHERE rating IN ('G', 'PG');

-- Using subqueries
SELECT title, rating
FROM film
WHERE rating IN (
    SELECT rating 
    FROM film 
    WHERE title LIKE '%PET%'
    );

-- Not in
SELECT title, rating
FROM film
WHERE rating NOT IN ('G', 'PG');

-- Matching conditions
SELECT last_name, first_name
FROM customer
WHERE left(last_name, 1) = 'Q';

-- Using wildcards
SELECT last_name, first_name
FROM customer
WHERE last_name LIKE '_A_T%S';

SELECT last_name, first_name
FROM customer
WHERE last_name LIKE 'Q%' OR last_name LIKE 'Y%';

-- Using regular expressions
SELECT last_name, first_name
FROM customer
WHERE last_name REGEXP '^[QY]';

-- Null values
SELECT rental_id, customer_id
FROM rental
WHERE return_date IS NULL;

SELECT rental_id, customer_id
FROM rental
WHERE return_date IS NOT NULL;

SELECT rental_id, customer_id, return_date
FROM rental
WHERE return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';

SELECT rental_id, customer_id, return_date
FROM rental
WHERE return_date IS NULL 
    OR return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';















