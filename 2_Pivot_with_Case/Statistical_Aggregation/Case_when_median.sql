/*
PERCENTILE_CONT -- calculated percentile 

Syntax:

SELECT 
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY column_name) AS median
FROM
    table_name
WHERE 
    column_name IS NOT NULL;
*/

SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY netprice) AS median
FROM
    sales;


SELECT
    product.categoryname,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sales.quantity * sales.netprice * sales.exchangerate) AS median_sales
FROM
    sales
LEFT JOIN product ON sales.productkey = product.productkey
GROUP BY
    product.categoryname
ORDER BY
    product.categoryname; 