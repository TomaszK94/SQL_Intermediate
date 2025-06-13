SELECT
    orderdate,
    TO_CHAR(orderdate,'YYYY')
FROM
    sales
ORDER BY
    RANDOM()
LIMIT 10;


SELECT
    orderdate,
    TO_CHAR(orderdate,'YYYY-MM')
FROM
    sales
ORDER BY
    RANDOM()
LIMIT 10;



SELECT 
    TO_CHAR(orderdate,'YYYY-MM') AS order_month,
    SUM(netprice * quantity * exchangerate) AS net_revenue,
    COUNT(DISTINCT customerkey) AS unique_customers
FROM
    sales
WHERE
    orderdate BETWEEN '2023-01-01' AND '2024-12-31'
GROUP BY
    order_month;