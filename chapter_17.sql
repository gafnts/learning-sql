-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 17
-- Working with large databases

CREATE TABLE sales (
    sale_id INT NOT NULL,
    cust_id INT NOT NULL,
    store_id INT NOT NULL,
    sale_date DATE NOT NULL,
    amount DECIMAL(9,2)
    )
PARTITION BY RANGE (yearweek(sale_date)) (
    PARTITION s1 VALUES LESS THAN (202002),
    PARTITION s2 VALUES LESS THAN (202003),
    PARTITION s3 VALUES LESS THAN (202004),
    PARTITION s4 VALUES LESS THAN (202005),
    PARTITION s5 VALUES LESS THAN (202006),
    PARTITION s999 VALUES LESS THAN (MAXVALUE)
);

SELECT partition_name, partition_method, partition_expression
FROM information_schema.partitions
WHERE table_name = 'sales'
ORDER BY partition_ordinal_position;

ALTER TABLE sales REORGANIZE PARTITION s999 INTO (
    PARTITION s6 VALUES LESS THAN (202007), 
    PARTITION s7 VALUES LESS THAN (202008),
    PARTITION s999 VALUES LESS THAN (MAXVALUE)
);

INSERT INTO sales
VALUES
    (81, 1, 1, '2020-01-18', 2765.15),
    (2, 3, 4, '2020-02-07', 5322.08);


