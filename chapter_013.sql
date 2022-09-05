-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 13
-- Indexes and constraints

SELECT first_name, last_name
FROM customer
WHERE last_name LIKE 'Y%';

CREATE INDEX idx_email
ON customer (email);

/* 
DROP INDEX idx_email
ON customer;
*/

SHOW INDEX FROM customer;

-- Unique indexes

DROP INDEX idx_email
ON customer;

CREATE UNIQUE INDEX idx_email
ON customer (email);

INSERT INTO customer (
    store_id, first_name, last_name, email, address_id, active
) VALUES (
    1, 'ALAN', 'KAHN', 'alan.kahn@sakilacustomer.org', 394, 1
);

CREATE INDEX idx_full_name
ON customer (last_name, first_name);




