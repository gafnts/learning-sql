-- Active: 1657824409167@@127.0.0.1@3306@sakila

-- Chapter 16
-- Analytic functions

SELECT 
    quarter(payment_date) quarter,
    monthname(payment_date) month,
    sum(amount) monthly_sales
FROM payment
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), monthname(payment_date);

