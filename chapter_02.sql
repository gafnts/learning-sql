-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Create tables

CREATE TABLE
    person (
        person_id SMALLINT UNSIGNED,
        fname VARCHAR(20),
        lname VARCHAR(20),
        eye_color ENUM('BR', 'BL', 'GR'),
        birth_data DATE,
        street VARCHAR(30),
        city VARCHAR(30),
        state VARCHAR(20),
        country VARCHAR(20),
        postal_code VARCHAR(20),
        CONSTRAINT pk_person PRIMARY KEY (person_id)
    );

CREATE TABLE
    favorite_food (
        person_id SMALLINT UNSIGNED,
        food VARCHAR(20),
        CONSTRAINT pk_favorite_food PRIMARY KEY (person_id, food) -- CONSTRAINT fk_food_person_id FOREIGN KEY (person_id),
        -- REFERENCES person (person_id)
    );

-- Make corrections

ALTER TABLE
    person MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;

ALTER TABLE person RENAME COLUMN birth_data TO birth_date;

-- Insert

INSERT INTO
    person (
        person_id,
        fname,
        lname,
        eye_color,
        birth_date
    )
VALUES (
        null,
        'William',
        'Turner',
        'BL',
        '1997-08-14'
    );

-- Query

SELECT
    person_id,
    fname,
    lname,
    birth_date
FROM person
WHERE person_id = 1;

SELECT
    person_id,
    fname,
    lname,
    birth_date
FROM person
WHERE lname = 'Turner';

-- More of insert

INSERT INTO favorite_food (person_id, food) VALUES (1, 'pizza');

INSERT INTO favorite_food (person_id, food) VALUES (1, 'cookies');

INSERT INTO
    favorite_food (person_id, food)
VALUES (1, 'chilaquiles');

SELECT food FROM favorite_food WHERE person_id = 1 ORDER BY food;

-- More of insert

INSERT INTO
    person (
        person_id,
        fname,
        lname,
        eye_color,
        birth_date,
        street,
        city,
        state,
        country,
        postal_code
    )
VALUES (
        null,
        'Susan',
        'Sarandon',
        'BL',
        '2000-01-31',
        '23 Maple St.',
        'Arlington',
        'VA',
        'USA',
        '20220'
    );

SELECT person_id, fname, lname, birth_date FROM person;

-- Updating things

UPDATE person
SET
    street = '2625 Trenton St.',
    city = 'Boston',
    state = 'MA',
    country = 'USA',
    postal_code = '02108'
WHERE person_id = 1;

SELECT * FROM person;

-- Deleting things

DELETE FROM person WHERE person_id = 1;

SELECT * FROM person;

-- Specify format of string

UPDATE person
SET
    birth_date = str_to_date('DEC-21-1980', '%b-%d-%Y')
WHERE person_id = 2;

-- Bye bye

DROP TABLE person;
DROP TABLE favorite_food;

-- The Sakila Database

