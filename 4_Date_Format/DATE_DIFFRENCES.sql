/*
INTERVAL - represent a span of time, such as days, months...

Syntax:

SELECT
    INTERVAL 'value unit'
*/

SELECT 
    CURRENT_DATE + INTERVAL '1 month'


SELECT 
    CURRENT_DATE,
    orderdate
FROM
    sales
WHERE
    CURRENT_DATE - INTERVAL '5 years' <= orderdate