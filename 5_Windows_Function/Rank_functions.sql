SELECT
    customerkey,
    COUNT(*)
FROM
    sales
GROUP BY
    customerkey
LIMIT 50;