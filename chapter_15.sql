-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 15
-- Metadata

SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'sakila'
ORDER BY 1;

SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'sakila'
    AND table_type = 'BASE TABLE'
ORDER BY 1;

SELECT table_name, is_updatable
FROM information_schema.views
WHERE table_schema = 'sakila'
ORDER BY 1;

SELECT column_name, data_type,
    character_maximum_length char_max_len,
    numeric_precision num_prcsn, numeric_scale num_scale
FROM information_schema.columns
WHERE table_schema = 'sakila' AND table_name = 'film'
ORDER BY ordinal_position;

SELECT index_name, non_unique, seq_in_index, column_name
FROM information_schema.statistics
WHERE table_schema = 'sakila' AND table_name = 'rental'
ORDER BY 1, 3;

SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'sakila'
ORDER BY 3,1;