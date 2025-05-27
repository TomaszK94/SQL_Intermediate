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
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY (CASE 
        WHEN sales.orderdate BETWEEN '2022-01-01' AND '2022-12-31' THEN (sales.quantity * sales.netprice * sales.exchangerate) 
    END)) AS median_sales_2022
FROM
    sales
LEFT JOIN product ON sales.productkey = product.productkey
GROUP BY
    product.categoryname
ORDER BY
    product.categoryname; 