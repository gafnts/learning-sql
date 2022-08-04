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

-- Multicolumn subqueries

SELECT
    actor_id, film_id
FROM film_actor
WHERE actor_id IN (
    SELECT actor_id 
    FROM actor
    WHERE last_name = 'MONROE'
) AND film_id IN (
    SELECT film_id
    FROM film
    WHERE rating = 'PG'
);

SELECT
    actor_id, film_id
FROM film_actor
WHERE (actor_id, film_id) IN (
    SELECT
        actor_id, film_id
        FROM actor 
            CROSS JOIN film
        WHERE last_name = 'MONROE'
            AND rating = 'PG'
);

-- Correlated subquaries

SELECT first_name, last_name
FROM customer c
WHERE 20 = (
    SELECT count(*) FROM rental r
    WHERE r.customer_id = c.customer_id
);

SELECT c.first_name, c.last_name
FROM customer c
WHERE (
    SELECT sum(p.amount)
    FROM payment p
    WHERE p.customer_id = c.customer_id
)
BETWEEN 180 AND 240;

-- The exists operator

SELECT c.first_name, c.last_name
FROM customer c
WHERE EXISTS (
    SELECT * FROM rental r
    WHERE r.customer_id = c.customer_id
        AND date(r.rental_date) < '2005-05-25'
);

SELECT a.first_name, a.last_name
FROM actor a
WHERE NOT EXISTS (
    SELECT * 
    FROM film_actor fa
        INNER JOIN film f USING(film_id)
    WHERE fa.actor_id = a.actor_id
        AND f.rating = 'R'
);

-- Data manpulation using correlated subqueries

UPDATE customer c
SET c.last_update = (
    SELECT max(r.rental_date) 
    FROM rental r
    WHERE r.customer_id = c.customer_id
);

UPDATE customer c
SET c.last_update = (
    SELECT max(r.rental_date) 
    FROM rental r
    WHERE r.customer_id = c.customer_id
)
WHERE EXISTS (
    SELECT * FROM rental r
    WHERE r.customer_id = c.customer_id
);

DELETE FROM customer 
WHERE 365 < ALL (
    SELECT datediff(now(), r.rental_date) days_since_last_rental
    FROM rental r
    WHERE r.customer_id = customer.customer_id
);

-- When to use subqueries

-- Subqueries as data sources

SELECT 
    c.customer_id,
    c.first_name, 
    c.last_name,
    p.num_rentals,
    p.tot_payments
FROM customer c
    INNER JOIN (
        SELECT 
            customer_id,
            count(*) num_rentals,
            sum(amount) tot_payments
            FROM payment
            GROUP BY customer_id
    ) p
    ON c.customer_id = p.customer_id;

SELECT 
    customer_id,
    count(*) num_rentals,
    sum(amount) tot_payments
FROM payment
GROUP BY customer_id;

SELECT 
    pg.name,
    count(*) num_customers
FROM (
    SELECT 
        customer_id,
        count(*) num_rentals,
        sum(amount) tot_payments
    FROM payment
    GROUP BY customer_id
) p
    INNER JOIN (
        SELECT 'Small fry' name, 0 low_limit, 74.99 high_limit
        UNION ALL
        SELECT 'Average jones' name, 75 low_limit, 149.99 high_limit
        UNION ALL
        SELECT 'Heavy hitters' name, 150 low_limit, 999999.99 high_limit
        ) pg
    ON p.tot_payments
        BETWEEN pg.low_limit AND pg.high_limit
GROUP BY pg.name;

-- Task oriented queries

SELECT
    c.first_name,
    c.last_name,
    ct.city,
    sum(p.amount) payments,
    count(*) rentals
FROM payment p
    INNER JOIN customer c USING(customer_id)
    INNER JOIN address a USING(address_id)
    INNER JOIN city ct USING(city_id)
GROUP BY c.first_name, c.last_name, ct.city;

SELECT
    c.first_name,
    c.last_name,
    ct.city,
    p.payments,
    p.rentals
FROM (
    SELECT 
        customer_id,
        count(*) rentals, 
        sum(amount) payments
    FROM payment
    GROUP BY customer_id
) p
    INNER JOIN customer c USING(customer_id)
    INNER JOIN address a USING(address_id)
    INNER JOIN city ct USING(city_id);

-- Common table expressions

WITH actors_s AS (
        SELECT actor_id, first_name, last_name
        FROM actor
        WHERE last_name LIKE 'S%'
    ),
    actor_s_pg AS (
        SELECT s.actor_id, s.first_name, s.last_name,
            f.film_id, f.title
        FROM actors_s s
            INNER JOIN film_actor fa USING (actor_id)
            INNER JOIN film f USING (film_id)
        WHERE f.rating = 'PG'
    ),
    actors_s_pg_revenue AS (
        SELECT spg.first_name, spg.last_name, p.amount
        FROM actors_s_pg spg
            INNER JOIN inventory i USING (film_id)
            INNER JOIN rental r USING (inventory_id)
            INNER JOIN payment p USING (rental_id)
    )
SELECT spg_rev.first_name, spg_rev.last_name,
    sum(spg_rev.amount) tot_revenue
FROM actors_s_pg_revenue spg_rev
GROUP BY spg_rev.first_name, spg_rev.last_name
ORDER BY 3 DESC;

-- Subqueries as expression generators

SELECT
    a.actor_id,
    a.first_name,
    a.last_name
FROM actor a
ORDER BY (
    SELECT count(*) FROM film_actor fa
    WHERE fa.actor_id = a.actor_id
) DESC;

INSERT INTO film_actor (actor_id, film_id, last_update)
VALUES (
    (SELECT actor_id FROM actor
    WHERE first_name = 'JENNIFER' AND last_name = 'DAVIS'),
    (SELECT film_id FROM film
    WHERE title = 'ACE GOLDFINGER'),
    now()
);