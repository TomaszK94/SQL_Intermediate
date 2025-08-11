SELECT
    cohort_year,
    COUNT(DISTINCT customerkey) AS total_customers,
    SUM(total_net_revenue) AS total_revenue,
    SUM(total_net_revenue) / COUNT(DISTINCT customerkey) AS customer_revenue
FROM
    cohort_analysis
GROUP BY
    cohort_year;


-- 

WITH purchase_days AS(
    SELECT
        customerkey,
        total_net_revenue,
        orderdate - MIN(orderdate) OVER (PARTITION BY customerkey) AS days_since_first_purchase
    FROM
        cohort_analysis
)

SELECT
    days_since_first_purchase,
    SUM(total_net_revenue) AS total_revenue,
    SUM(total_net_revenue) / (SELECT SUM(total_net_revenue) FROM cohort_analysis) * 100 AS percentage_of_total
FROM
    purchase_days
GROUP BY
    days_since_first_purchase
ORDER BY
    days_since_first_purchase


-- Taking into consideration only first purchase

SELECT
    cohort_year,
    COUNT(DISTINCT customerkey) AS total_customers,
    SUM(total_net_revenue) AS total_revenue,
    SUM(total_net_revenue) / COUNT(DISTINCT customerkey) AS customer_revenue
FROM
    cohort_analysis
WHERE
    orderdate = first_purchase_date
GROUP BY
    cohort_year;