SELECT
    customerkey,
    orderdate,
    EXTRACT(YEAR FROM MIN(orderdate) OVER(PARTITION BY customerkey)) AS cohor_year
FROM
    sales
ORDER BY
    customerkey
LIMIT 10;
