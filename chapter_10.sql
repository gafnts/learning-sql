-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 10
-- Joins revisited

-- Outer joins

SELECT f.film_id, f.title, count(*) num_copies
FROM film f
    INNER JOIN inventory i USING (film_id)
GROUP BY f.film_id, f.title;

SELECT f.film_id, f.title, count(i.inventory_id) num_copies
FROM film f
    LEFT OUTER JOIN inventory i USING (film_id)
GROUP BY f.film_id, f.title;

SELECT f.film_id, f.title, i.inventory_id
FROM film f
    INNER JOIN inventory i USING (film_id)
WHERE f.film_id BETWEEN 13 AND 15;

SELECT f.film_id, f.title, i.inventory_id
FROM film f
    LEFT OUTER JOIN inventory i USING (film_id)
WHERE f.film_id BETWEEN 13 AND 15;

-- Left versus right outer joins

SELECT f.film_id, f.title, i.inventory_id
FROM inventory i
    RIGHT OUTER JOIN film f USING (film_id)
WHERE f.film_id BETWEEN 13 AND 15;

-- Three-way outer joins

SELECT f.film_id, f.title, i.inventory_id, r.rental_date
FROM film f
    LEFT JOIN inventory i USING (film_id)
    LEFT JOIN rental r USING (inventory_id)
WHERE f.film_id BETWEEN 13 AND 15;

-- Cross joins

SELECT c.name category_name, l.name language_name
FROM category c
    CROSS JOIN language l;

-- Natural joins

SELECT c.first_name, c.last_name, date(r.rental_date)
FROM customer c
    NATURAL JOIN rental r;

SELECT c.first_name, c.last_name, date(r.rental_date) date
FROM (
    SELECT customer_id, first_name, last_name
    FROM customer
) c
    NATURAL JOIN rental r;


