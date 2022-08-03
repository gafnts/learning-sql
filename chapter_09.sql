-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Subqueries

/*
Hi! Just a quick reminder. Life is something you didn't create, 
you didn't ask for and you don't manage. So don't take anything 
too seriously. Feelings and hedonic tones arise just like waves 
in a beach; everything is impermanent and ever changing.

Just do what you are naturally drawn to do, love yourself and
hope for the best.
*/

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id = (
    SELECT MAX(customer_id) FROM customer
);

-- Noncorrelated subqueries

-- Scalar subquery

SELECT 
    city_id,
    city
FROM city
WHERE country_id <> (
    SELECT country_id 
    FROM country 
    WHERE country = 'India'
);

-- Multiple-row, single-column subqueries

SELECT country_id
FROM country
WHERE country IN ('Canada', 'Mexico');

SELECT country_id
FROM country
WHERE country = 'Canada' OR country = 'Mexico';

SELECT 
    city_id, 
    city
FROM city
WHERE country_id IN (
    SELECT country_id
    FROM country
    WHERE country IN ('Canada', 'Mexico')
);

SELECT 
    city_id, 
    city
FROM city
WHERE country_id NOT IN (
    SELECT country_id
    FROM country
    WHERE country IN ('Canada', 'Mexico')
);

-- The all operator

SELECT
    first_name,
    last_name
FROM customer
WHERE customer_id <> ALL (
    SELECT customer_id
    FROM payment
    WHERE amount = 0
);

SELECT
    first_name,
    last_name
FROM customer
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM payment
    WHERE amount = 0
);

SELECT customer_id, count(*)
FROM rental
GROUP BY customer_id
HAVING count(*) > ALL (
    SELECT count(*)
    FROM rental
        INNER JOIN customer USING(customer_id)
        INNER JOIN address USING(address_id)
        INNER JOIN city USING(city_id)
        INNER JOIN country USING(country_id)
    WHERE country IN ('United States', 'Mexico', 'Canada')
    GROUP BY customer_id
);

-- The any operator

SELECT customer_id, sum(amount)
FROM payment
GROUP BY customer_id
HAVING sum(amount) > ANY (
    SELECT sum(amount)
    FROM payment
        INNER JOIN customer USING(customer_id)
        INNER JOIN address USING(address_id)
        INNER JOIN city USING(city_id)
        INNER JOIN country USING(country_id)
    WHERE country IN ('Bolivia', 'Paraguay', 'Chile')
    GROUP BY country
);


