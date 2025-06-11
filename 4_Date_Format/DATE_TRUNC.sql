SELECT 
    orderdate,
    DATE_TRUNC('month', orderdate)
FROM
    sales
ORDER BY RANDOM()
LIMIT 10;