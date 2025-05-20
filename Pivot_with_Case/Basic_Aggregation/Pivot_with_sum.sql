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

SELECT
    product.categoryname,
    SUM(sales.quantity * sales.netprice * sales.exchangerate) AS net_revenue
FROM
    sales
LEFT JOIN product ON sales.productkey = product.productkey
GROUP BY
    product.categoryname
ORDER BY
    product.categoryname;