SELECT 
    orderdate,
    DATE_TRUNC('month', orderdate)
FROM
    sales
ORDER BY RANDOM()
LIMIT 10;


SELECT 
    orderdate,
    DATE_TRUNC('month', orderdate)::DATE AS order_month
FROM
    sales
ORDER BY RANDOM()
LIMIT 10;


SELECT 
    DATE_TRUNC('month', orderdate)::DATE AS order_month,
    SUM(netprice * quantity * exchangerate) AS net_revenue,
    COUNT(DISTINCT customerkey) AS unique_customers
FROM
    sales
GROUP BY
    order_month
LIMIT 10;