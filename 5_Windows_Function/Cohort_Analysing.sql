SELECT
    customerkey,
    orderdate,
    MIN(orderdate) OVER(PARTITION BY customerkey) AS cohor_date
FROM
    sales
ORDER BY
    customerkey
LIMIT 10;
