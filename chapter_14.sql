-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 14
-- Views

CREATE VIEW customer_vw (
    customer_id,
    first_name,
    last_name,
    email
) AS
SELECT
    customer_id,
    first_name,
    last_name,
    concat(substr(email, 1, 2), '*****', substr('email', -4)) email
FROM customer;

SELECT first_name, email
FROM customer_vw;

describe customer_vw;

SELECT
    first_name,
    count(*),
    min(last_name),
    max(last_name)
FROM customer_vw
WHERE first_name LIKE 'J%'
GROUP BY first_name
HAVING count(*) > 1
ORDER BY 1;

SELECT cv.first_name, cv.last_name, p.amount
FROM customer_vw cv
INNER JOIN payment p
ON cv.customer_id = p.customer_id
WHERE p.amount >= 11;

CREATE VIEW active_customer_vw
     (customer_id,
      first_name,
      last_name,
      email
) AS
    SELECT
      customer_id,
      first_name,
      last_name,
      concat(substr(email,1,2), '*****', substr(email, -4)) email
FROM customer WHERE active = 1;

CREATE VIEW sales_by_film_category_two
    AS
    SELECT
      c.name AS category,
      SUM(p.amount) AS total_sales
    FROM payment AS p
      INNER JOIN rental AS r ON p.rental_id = r.rental_id
      INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
      INNER JOIN film AS f ON i.film_id = f.film_id
      INNER JOIN film_category AS fc ON f.film_id = fc.film_id
      INNER JOIN category AS c ON fc.category_id = c.category_id
    GROUP BY c.name
    ORDER BY total_sales DESC;

CREATE VIEW film_stats
    AS
    SELECT f.film_id, f.title, f.description, f.rating,
     (SELECT c.name
      FROM category c
        INNER JOIN film_category fc
        ON c.category_id = fc.category_id
      WHERE fc.film_id = f.film_id) category_name,
     (SELECT count(*)
      FROM film_actor fa
      WHERE fa.film_id = f.film_id
     ) num_actors,
     (SELECT count(*)
      FROM inventory i
      WHERE i.film_id = f.film_id
     ) inventory_cnt,
     (SELECT count(*)
      FROM inventory i
        INNER JOIN rental r
        ON i.inventory_id = r.inventory_id
      WHERE i.film_id = f.film_id
     ) num_rentals
FROM film f;

CREATE VIEW customer_vw_two
     (customer_id,
      first_name,
      last_name,
      email
) AS
    SELECT
      customer_id,
      first_name,
      last_name,
      concat(substr(email,1,2), '*****', substr(email, -4)) email
    FROM customer;

UPDATE customer_vw
SET last_name = 'SMITH-ALLEN'
WHERE customer_id = 1;

SELECT first_name, last_name, email
FROM customer
WHERE customer_id = 1;

CREATE VIEW customer_details
    AS
    SELECT c.customer_id,
      c.store_id,
      c.first_name,
      c.last_name,
      c.address_id,
      c.active,
      c.create_date,
      a.address,
      ct.city,
      cn.country,
      a.postal_code
    FROM customer c
      INNER JOIN address a
      ON c.address_id = a.address_id
      INNER JOIN city ct
      ON a.city_id = ct.city_id
      INNER JOIN country cn
      ON ct.country_id = cn.country_id;

UPDATE customer_details
SET last_name = 'SMITH-ALLEN', active = 0
WHERE customer_id = 1;

UPDATE customer_details
SET address = '999 Mockingbird Lane'
WHERE customer_id = 1;

UPDATE customer_details
SET last_name = 'SMITH-ALLEN', active = 0, address = '999 Mockingbird Lane'
WHERE customer_id = 1;

INSERT INTO customer_details
(customer_id, store_id, first_name, last_name,
address_id, active, create_date)
VALUES (9998, 1, 'BRIAN', 'SALAZAR', 5, 1, now());