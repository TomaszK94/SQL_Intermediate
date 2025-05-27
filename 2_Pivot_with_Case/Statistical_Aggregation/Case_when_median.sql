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

