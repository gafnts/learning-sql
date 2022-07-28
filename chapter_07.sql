-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 07

-- Working with string data

CREATE TABLE string_tbl (
    char_fld CHAR(30),
    vchar_fld VARCHAR(30),
    text_fld TEXT
);

INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES (
    'This is char data',
    'This is varchar data',
    'This is text data'
);

UPDATE string_tbl
SET vchar_fld = 'This is a piece of extremely long varchar data';

SELECT quote(text_fld)
FROM string_tbl;

-- String manipulation

DELETE FROM string_tbl;

INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES (
    'This string is 28 characters',
    'This string is 28 characters',
    'This string is 28 characters'
);

SELECT 
    LENGTH(char_fld) char_length,
    LENGTH(vchar_fld) char_length,
    LENGTH(text_fld) char_length
FROM string_tbl;

SELECT POSITION('characters' IN vchar_fld)
FROM string_tbl;

SELECT LOCATE('is', vchar_fld, 5)
FROM string_tbl;

DELETE FROM string_tbl;

INSERT INTO string_tbl (vchar_fld)
VALUES 
    ('abcd'),
    ('xyz'),
    ('QRSTUV'),
    ('qrstuv'),
    ('12345');

SELECT vchar_fld
FROM string_tbl
ORDER BY vchar_fld;

SELECT name, name LIKE '%y' AS ends_with_y
FROM category;

-- String functions that return strings

DELETE FROM string_tbl;

INSERT INTO string_tbl (text_fld)
VALUES ('This string was 29 characters');

UPDATE string_tbl
SET text_fld = CONCAT(text_fld, ', but now it is longer');

SELECT text_fld
FROM string_tbl;

SELECT CONCAT(first_name, ' ', last_name,
    ' has been a customer since ', date(create_date)) AS cust_narrative
FROM customer;

SELECT REPLACE('goodbye world', 'goodbye', 'hello')
FROM dual;

SELECT SUBSTRING('goodbye cruel world', 9, 5);

-- Working with numeric data

SELECT (37*59) / (78 - (8*6));

SELECT MOD(10, 4);

SELECT 
    POW(2, 10) kilobyte,
    POW(2, 20) megabyte,
    POW(2, 30) gigabyte,
    POW(2, 40) terabyte;

-- Controlling number precision

SELECT CEIL(72.000000001), FLOOR(72.999999999);

SELECT ROUND(72.49999), ROUND(72.5), ROUND(72.50001);

SELECT ROUND(72.49999, 1), ROUND(72.5, 2), ROUND(72.50001, 3);

SELECT TRUNCATE(72.0909, 1), TRUNCATE(72.0909, 2), TRUNCATE(72.0909, 3);

SELECT ROUND(17, -1), TRUNCATE(17, -1);

-- Handling signed data

SELECT amount, SIGN(amount), ABS(amount)
FROM payment;

-- Working with temporal data

SELECT @@global.time_zone, @@session.time_zone;

SELECT time_zone = 'Europe/Zurich';

-- Generating temporal data

UPDATE rental
SET return_date = '2022-09-17 15:30:00'
WHERE rental_id = 99999;

SELECT CAST('2022-09-17 15:30:00' AS DATETIME) Date;

SELECT 
    CAST('2022-09-17 15:30:00' AS DATE) date_field,
    CAST('108:17:57' AS TIME) time_field;

UPDATE rental
SET return_date = STR_TO_DATE('September 17, 2019', '%M %d, %Y')
WHERE rental_id = 1;

SELECT * FROM rental WHERE rental_id = 1;

SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();

-- Manipulating temporal data

SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY);

UPDATE actor
SET last_update = DATE_ADD(last_update, INTERVAL '9-10' YEAR_MONTH)
WHERE actor_id = 1;

SELECT * FROM actor WHERE actor_id = 1;

SELECT DAYNAME(last_update) FROM actor WHERE actor_id = 1;

SELECT EXTRACT(YEAR FROM last_update) FROM actor WHERE actor_id = 1;

SELECT 
    customer_id AS id,
    create_date, last_update,
    DATEDIFF(last_update, create_date) AS diff
FROM customer;

-- Conversion functions

SELECT CAST('123456789' AS SIGNED INTEGER);

SELECT CAST('1234ABC56789' AS UNSIGNED INTEGER);









