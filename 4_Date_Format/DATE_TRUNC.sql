SELECT 
    orderdate,
    DATE_TRUNC('month', orderdate)
FROM
    sales
ORDER BY RANDOM()
LIMIT 10;


SELECT 
    orderdate,
    DATE_TRUNC('month', orderdate)::DATE
FROM
    sales
ORDER BY RANDOM()
LIMIT 10;