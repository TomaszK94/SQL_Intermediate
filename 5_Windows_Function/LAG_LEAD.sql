SELECT 
    TO_CHAR(orderdate, 'YYYY-MM') AS month,
    SUM(exchangerate * quantity * netprice) AS net_revenue
FROM
    sales
GROUP BY 
    month
ORDER BY
    month