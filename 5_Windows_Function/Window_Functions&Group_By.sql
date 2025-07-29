SELECT
    customerkey,
    COUNT(*) OVER (PARTITION BY customerkey) AS total_order
FROM
    sales