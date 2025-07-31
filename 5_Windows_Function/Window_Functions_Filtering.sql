/*
Filtering Before Windows Function
Use WHERE to filter rows before aggregation.

Syntax:

SELECT
    column name,
    window_function(column_to_aggregate) 
        OVER (PARTITION BY partition_column ORDER BY order_column) AS window_column_allias
FROM 
    table_name
WHERE
    condition --> Filters data BEFORE applying window function

*/

SELECT
    customerkey,
    EXTRACT(YEAR FROM MIN(orderdate) OVER (PARTITION BY customerkey)) AS cohort_year
FROM 
    sales
WHERE 
    orderdate >= '2020-01-01'