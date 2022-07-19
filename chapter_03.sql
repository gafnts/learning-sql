-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 03

-- The SELECT clause

SELECT * FROM language;

SELECT language_id, name FROM language;

SELECT
    language_id,
    'COMMON' language_usage,
    language_id * 3.1415927 lang_pi_value,
    upper(name) language_name
FROM language;

SELECT version(), user(), database();

SELECT
    language_id,
    'COMMON' AS language_usage,
    language_id * 3.1415927 AS lang_pi_value,
    upper(name) AS language_name
FROM language;

SELECT DISTINCT actor_id FROM film_actor ORDER BY actor_id;

-- The FROM clause

-- Derived (subquery-generated) tables

SELECT
    CONCAT(
        cust.last_name,
        ', ',
        cust.first_name
    ) AS full_name
FROM (
        SELECT
            first_name,
            last_name,
            email
        FROM customer
        WHERE
            first_name = 'JESSIE'
    ) cust;

-- Temporary (volatile data) tables

CREATE TEMPORARY
TABLE
    actors_j (
        actor_id SMALLINT(5),
        first_name VARCHAR(45),
        last_name VARCHAR(45)
    );

INSERT INTO actors_j
SELECT
    actor_id,
    first_name,
    last_name
FROM actor
WHERE last_name LIKE 'J%';

SELECT * FROM actors_j;

-- Virtual tables (Views)

CREATE VIEW cust_vm AS 
	SELECT customer_id, first_name, last_name, active FROM 
customer; 

SELECT first_name, last_name FROM cust_vm WHERE active = 0;

-- Table links

SELECT
    customer.first_name,
    customer.last_name,
    TIME(rental.rental_date) AS rental_time
FROM customer
    INNER JOIN rental ON customer.customer_id = rental.customer_id
WHERE
    DATE(rental.rental_date) = '2005-06-14';

-- Defining table aliases

SELECT
    c.first_name,
    c.last_name,
    TIME(r.rental_date) AS rental_time
FROM customer AS c
    INNER JOIN rental AS r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14';

-- The WHERE clause

SELECT title FROM film WHERE rating = 'G' AND rental_duration >= 7;

SELECT title FROM film WHERE rating = 'G' OR rental_duration >= 7;

SELECT
    title,
    rating,
    rental_duration
FROM film
WHERE (
        rating = 'G'
        AND rental_duration >= 7
    )
    OR (
        rating = 'PG-13'
        AND rental_duration < 4
    );

-- The GROUP BY and HAVING clauses

SELECT
    c.first_name,
    c.last_name,
    count(*) AS total_rentals
FROM customer AS c
    INNER JOIN rental AS r ON c.customer_id = r.customer_id
GROUP BY
    c.first_name,
    c.last_name
HAVING count(*) >= 40;

-- The ORDER BY clause

SELECT
    c.first_name,
    c.last_name,
    time(r.rental_date) AS rental_time
FROM customer AS c
    INNER JOIN rental AS r ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY c.last_name, c.first_name;

SELECT
    c.first_name,
    c.last_name,
    TIME(r.rental_date) AS rental_time
FROM customer AS c
    INNER JOIN rental AS r ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY TIME(r.rental_date) DESC;

SELECT
    c.first_name,
    c.last_name,
    TIME(r.rental_date) AS rental_time
FROM customer AS c
    INNER JOIN rental AS r ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY 2 DESC;



