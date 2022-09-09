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

SELECT 
    quarter(payment_date) quarter,
    monthname(payment_date) month,
    sum(amount) monthly_sales,
    max(sum(amount)) over () max_overall_sales,
    max(sum(amount)) over(
        partition by quarter(payment_date)
        ) max_quarter_sales
FROM payment
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), monthname(payment_date);

SELECT quarter(payment_date) quarter,
    monthname(payment_date) month_nm,
    sum(amount) monthly_sales,
    rank() over (order by sum(amount) desc) sales_rank
FROM payment
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), monthname(payment_date);

SELECT quarter(payment_date) quarter,
    monthname(payment_date) month_nm,
    sum(amount) monthly_sales,
    rank() over (
        partition by quarter(payment_date)
        order by sum(amount) desc
        ) qtr_sales_rank
FROM payment
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), monthname(payment_date);

SELECT customer_id, count(*) num_rentals
FROM rental
GROUP BY customer_id
ORDER BY 2 desc;

SELECT customer_id, count(*) num_rentals,
    row_number() over (order by count(*) desc) row_number_rnk,
    rank() over (order by count(*) desc) rank_rnk,
    dense_rank() over (order by count(*) desc) dense_rank_rnk
FROM rental
GROUP BY customer_id
ORDER BY 2 desc;

SELECT customer_id,
    monthname(rental_date)rental_month,
    count(*) num_rentals
FROM rental
GROUP BY customer_id, monthname(rental_date)
ORDER BY 2, 3 desc;

SELECT customer_id,
    monthname(rental_date) rental_month,
    count(*) num_rentals,
    rank() over (
        partition by monthname(rental_date)
        order by count(*) desc
        ) rank_rnk
FROM rental
GROUP BY customer_id, monthname(rental_date)
ORDER BY 2, 3 desc;

SELECT customer_id, rental_month, num_rentals,
    rank_rnk ranking
FROM
    (SELECT customer_id,
    monthname(rental_date) rental_month,
    count(*) num_rentals,
    rank() over (
        partition by monthname(rental_date)
        order by count(*) desc
        ) rank_rnk
    FROM rental
    GROUP BY customer_id, monthname(rental_date)
    ) cust_rankings
WHERE rank_rnk <= 5
ORDER BY rental_month, num_rentals desc, rank_rnk;

SELECT monthname(payment_date) payment_month, amount, 
    sum(amount)
        over (partition by monthname(payment_date)) monthly_total,
    sum(amount) 
        over () grand_total
FROM payment
WHERE amount >= 10
ORDER BY 1;

SELECT monthname(payment_date) payment_month,
    sum(amount) month_total,
    round(
        sum(amount) / sum(sum(amount)) over () * 100, 2
        ) pct_of_total
FROM payment
GROUP BY monthname(payment_date);

SELECT
    monthname(payment_date) payment_month,
    sum(amount) month_total,
    CASE sum(amount)
        WHEN max(sum(amount)) over () THEN 'High'
        WHEN min(sum(amount)) over () THEN 'Low'
        ELSE 'Middle'
    END descriptor
FROM payment
GROUP BY monthname(payment_date);

SELECT yearweek(payment_date) payment_week,
    sum(amount) week_total,
    sum(sum(amount)) over (
        order by yearweek(payment_date)
        rows unbounded preceding
        ) rolling_sum
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT yearweek(payment_date) payment_week,
    sum(amount) week_total,
    avg(sum(amount)) over (
        order by yearweek(payment_date)
        rows between 1 preceding and 1 following
        ) rolling_3wk_avg
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT 
    yearweek(payment_date) payment_week,
    sum(amount) week_total,
    lag(sum(amount), 1) over (
        order by yearweek(payment_date)
    ) prev_wk_tot,
    lead(sum(amount), 1) over(
        order by yearweek(payment_date)
    ) next_week_tot
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT 
    yearweek(payment_date) payment_week,
    sum(amount) week_total,
    round((sum(amount) - lag(sum(amount), 1)
        over (order by yearweek(payment_date)))
        / lag(sum(amount), 1)
            over (order by yearweek(payment_date))
        * 100, 1) pct_diff
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT f.title,
    group_concat(a.last_name order by a.last_name
    separator ', ') actors
FROM actor a
    INNER JOIN film_actor fa
    ON a.actor_id = fa.actor_id
    INNER JOIN film f
    ON fa.film_id = f.film_id
GROUP BY f.title
HAVING count(*) = 3;

