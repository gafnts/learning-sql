-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 15
-- Metadata

SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'sakila'
ORDER BY 1;

