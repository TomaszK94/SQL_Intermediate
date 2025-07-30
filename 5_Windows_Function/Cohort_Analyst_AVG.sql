/*

SELECT
    AVG() OVER(
    PARTITION BY partition_expression
    ) AS window_column
FROM
    table_name

*/

-- LTV --> Custome Lifetime Value


SELECT
    customerkey,
    EXTRACT(YEAR FROM MIN(orderdate)) AS cohort_year,
    SUM(quantity * netprice * exchangerate) AS customer_ltv
FROM 
    sales
GROUP BY
    customerkey
ORDER BY 
    customerkey