SELECT
    TO_CHAR(orderdate, 'YYYY-MM') AS month,
    SUM(quantity * netprice * exchangerate) AS net_revenue
FROM
    sales
WHERE
    EXTRACT(YEAR FROM orderdate) = 2023
GROUP BY
    month 
ORDER BY
    month