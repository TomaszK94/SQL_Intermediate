SELECT
    orderdate,
    TO_CHAR(orderdate,'YYYY')
FROM
    sales
ORDER BY
    RANDOM()
LIMIT 10;