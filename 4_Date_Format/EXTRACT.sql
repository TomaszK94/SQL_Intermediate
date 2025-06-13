/*
EXTRACT() - extract specific components (y,m,d) from date or timestamp

SYNTAX:
EXTRACT(unit FROM source)

EXTRACT(YEAR FROM orderdate)
*/


SELECT
    orderdate,
    EXTRACT(YEAR FROM orderdate) AS order_year,
    EXTRACT(MONTH FROM orderdate) AS order_month,
    EXTRACT(DAY FROM orderdate) AS order_day
FROM
    sales
ORDER BY
    RANDOM()
LIMIT 10;


SELECT 
    EXTRACT(YEAR FROM orderdate) AS order_year,
    EXTRACT(MONTH FROM orderdate) AS order_month,
    SUM(netprice * quantity * exchangerate) AS net_revenue,
    COUNT(DISTINCT customerkey) AS unique_customers
FROM
    sales
WHERE
    orderdate BETWEEN '2022-01-01' AND '2024-12-31'
GROUP BY
    order_year,
    order_month
ORDER BY
    order_year,
    order_month;