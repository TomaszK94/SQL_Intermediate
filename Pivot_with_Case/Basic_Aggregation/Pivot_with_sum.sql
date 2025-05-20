/* SUM(CASE WHEN)
SYNTAX:

SUM(CASE WHEN condition THEN column ELSE 0 END) AS allias

EXAMPLE:

SELECT 
    SUM(CASE WHEN region = 'North' THEN sales END) AS north_sales
    SUM(CASE WHEN region = 'South' THEN sales END) AS south_sales
FROM 
    sales_data;
*/
