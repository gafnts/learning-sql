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

-- Bitmap indexes

SELECT customer_id, first_name, last_name
FROM customer
WHERE first_name LIKE 'S%' AND last_name LIKE 'P%';

EXPLAIN
SELECT customer_id, first_name, last_name
FROM customer
WHERE first_name LIKE 'S%' AND last_name LIKE 'P%';

-- Constraints

CREATE TABLE customer ( 
    customer_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT, 
    store_id TINYINT UNSIGNED NOT NULL, 
    first_name VARCHAR(45) NOT NULL, 
    last_name VARCHAR(45) NOT NULL, 
    email VARCHAR(50) DEFAULT NULL, 
    address_id SMALLINT UNSIGNED NOT NULL, 
    active BOOLEAN NOT NULL DEFAULT TRUE, 
    create_date DATETIME NOT NULL, 
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP, 
    PRIMARY KEY (customer_id), 
    KEY idx_fk_store_id (store_id), 
    KEY idx_fk_address_id (address_id), 
    KEY idx_last_name (last_name), 
    CONSTRAINT fk_customer_address FOREIGN KEY (address_id) 
        REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE, 
    CONSTRAINT fk_customer_store FOREIGN KEY (store_id) 
        REFERENCES store (store_id) ON DELETE RESTRICT ON UPDATE CASCADE 
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;



