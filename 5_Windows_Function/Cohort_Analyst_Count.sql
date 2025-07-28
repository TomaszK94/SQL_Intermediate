/*

COUNT - Counts the values, DISTINCT can be added to get the unique count.

Syntax:

SELECT
    COUNT() OVER(
        PARTITION BY partition_expression
        ) AS window_column_allias
FROM 
    table_name

*/