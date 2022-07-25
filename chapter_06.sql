-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 06

-- The UNION operator

SELECT
    'CUST' typ,
    c.first_name,
    c.last_name
FROM customer c
UNION ALL
SELECT
    'ACTR' typ,
    a.first_name,
    a.last_name
FROM actor a;

SELECT
    c.first_name,
    c.last_name
FROM customer c
WHERE
    c.first_name LIKE 'J%'
    AND c.last_name LIKE 'D%'
UNION ALL
SELECT
    a.first_name,
    a.last_name
FROM actor a
WHERE
    a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%';

SELECT
    c.first_name,
    c.last_name
FROM customer c
WHERE
    c.first_name LIKE 'J%'
    AND c.last_name LIKE 'D%'
UNION
SELECT
    a.first_name,
    a.last_name
FROM actor a
WHERE
    a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%';

-- The INTERSECT operator

/*
 The INTERSECT operator doesn't exists in MySQL,
 one can simulate the operator with IN and in some 
 more complex scenarios with EXISTS.
 More infor here: https://www.techonthenet.com/mysql/intersect.php
 */

SELECT
    c.first_name,
    c.last_name
FROM customer c
WHERE
    c.first_name LIKE 'J%'
    AND c.last_name LIKE 'D%'
    AND EXISTS (
        SELECT
            a.first_name,
            a.last_name
        FROM actor a
        WHERE
            a.first_name LIKE 'J%'
            AND a.last_name LIKE 'D%'
    );

-- The EXCEPT operator

SELECT
    a.first_name,
    a.last_name
FROM actor a
WHERE
    a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%'
    AND NOT EXISTS (
        SELECT
            c.first_name,
            c.last_name
        FROM customer c
        WHERE
            c.first_name LIKE 'J%'
            AND c.last_name LIKE 'D%'
    );

-- Set operation precendence

SELECT
    a.first_name,
    a.last_name
FROM actor a
WHERE
    a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%'
UNION ALL
SELECT
    a.first_name,
    a.last_name
FROM actor a
WHERE
    a.first_name LIKE 'M%'
    AND a.last_name LIKE 'T%'
UNION
SELECT
    c.first_name,
    c.last_name
FROM customer c
WHERE
    c.first_name LIKE '%J'
    AND c.last_name LIKE 'D%';