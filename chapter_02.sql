-- Active: 1657824409167@@127.0.0.1@3306@sakila

CREATE TABLE
    person (
        person_id SMALLINT UNSIGNED,
        fname VARCHAR(20),
        lname VARCHAR(20),
        eye_color CHAR(2),
        birth_data DATE,
        street VARCHAR(30),
        city VARCHAR(30),
        state VARCHAR(20),
        country VARCHAR(20),
        postal_code VARCHAR(20),
        CONSTRAINT pk_person PRIMARY KEY (person_id)
    )



