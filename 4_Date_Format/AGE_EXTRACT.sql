-- EXAMPLE
SELECT AGE('2025-01-23', '2025-01-01')
-- AGE --> Interval we cannot make any operation likes + - 


SELECT
EXTRACT(DAY FROM AGE('2025-06-23', '2025-01-01')) - 10


SELECT
    DATE_PART('year', orderdate) AS order_year,
    ROUND(AVG(EXTRACT(DAY FROM AGE(deliverydate, orderdate))),2) AS avg_processing_time,
    ROUND(SUM(quantity * netprice * exchangerate)) AS net_revenue
FROM
    sales
WHERE
    orderdate >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY 
    order_year
ORDER BY
    order_year;