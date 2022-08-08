-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 11
-- Conditional logic

SELECT 
    first_name, 
    last_name,
    CASE WHEN
        active = 1 THEN 'ACTIVE'
        ELSE 'INACTIVE'
    END activity_type
FROM customer;

SELECT
    c.first_name,
    c.last_name,
    CASE WHEN
        active = 0 THEN 0
        ELSE (
            SELECT count(*) FROM rental r
            WHERE r.customer_id = c.customer_id
        )
    END num_rentals
FROM customer c;

SELECT 
    monthname(rental_date) rental_month,
    count(*) num_rentals
FROM rental
WHERE rental_date BETWEEN '2005-05-01' AND '2005-08-01'
GROUP BY monthname(rental_date);

SELECT
    SUM(CASE WHEN monthname(rental_date) = 'May' THEN 1
        ELSE 0 END) may_rentals,
    SUM(CASE WHEN monthname(rental_date) = 'June' THEN 1
        ELSE 0 END) june_rentals,
    SUM(CASE WHEN monthname(rental_date) = 'July' THEN 1
        ELSE 0 END) july_rentals
FROM rental
WHERE rental_date BETWEEN '2005-05-01' AND '2005-08-01';

-- Checking for existence

SELECT f.title,
    CASE (
        SELECT count(*) FROM inventory i
        WHERE i.film_id = f.film_id
    )
        WHEN 0 THEN 'Out of stock'
        WHEN 1 THEN 'Scarce'
        WHEN 2 THEN 'Scarce'
        WHEN 3 THEN 'Available'
        WHEN 4 THEN 'Available'
        ELSE 'Rent it all ready'
    END availability
FROM film f;


-- Division by zero errors

SELECT 
    c.first_name, 
    c.last_name,
    sum(p.amount) tot_payment_amt,
    count(p.amount) num_payments,
    sum(p.amount) /
        CASE WHEN count(p.amount) = 0 THEN 1
            ELSE count(p.amount)
        END avg_payment
FROM customer c
    LEFT OUTER JOIN payment p USING (customer_id)
GROUP BY c.first_name, c.last_name;

-- Conditional updates

UPDATE customer
SET active = 
    CASE
        WHEN 90 <= (
            SELECT datediff(now(), max(rental_date))
            FROM rental r
            WHERE r.customer_id = customer.customer_id
        )
        THEN 0
        ELSE 1
    END
WHERE active = 1;

-- Handling null values

SELECT c.first_name, c.last_name,
    CASE 
        WHEN a.address IS NULL THEN 'Unknown'
        ELSE a.address
    END address,
    CASE 
        WHEN ct.city IS NULL THEN 'Unknown'
        ELSE ct.city
    END city
FROM customer c
    LEFT JOIN address a ON c.address_id = a.address_id
    LEFT JOIN city ct ON a.city_id = ct.city_id;

SELECT c.first_name, c.last_name,
    CASE 
        WHEN a.address IS NULL THEN 'Unknown'
        ELSE a.address
    END address,
    CASE 
        WHEN ct.city IS NULL THEN 'Unknown'
        ELSE ct.city
    END city,
    CASE 
        WHEN cn.country IS NULL THEN 'Unknown'
        ELSE cn.country
    END country
FROM customer c
    LEFT JOIN address a USING(address_id)
    LEFT JOIN city ct USING(city_id)
    LEFT JOIN country cn USING(country_id);

