SELECT 
    orderdate,
    COUNT(customerkey) AS total_customer
FROM 
    sales
GROUP BY
    orderdate
ORDER BY
    orderdate;