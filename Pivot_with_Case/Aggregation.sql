SELECT 
    orderdate,
    COUNT(DISTINCT customerkey) AS total_customer
FROM 
    sales
WHERE
    orderdate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY
    orderdate
ORDER BY
    orderdate;