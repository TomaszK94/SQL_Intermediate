SELECT 
    sales.orderdate,
    COUNT(DISTINCT sales.customerkey) AS total_customer,
    COUNT(DISTINCT CASE WHEN customer.continent = 'Europe' THEN sales.customerkey END) AS eu_customers
FROM 
    sales
LEFT JOIN customer ON customer.customerkey = sales.customerkey
WHERE
    sales.orderdate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY
    sales.orderdate
ORDER BY
    sales.orderdate;