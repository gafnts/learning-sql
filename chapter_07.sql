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





