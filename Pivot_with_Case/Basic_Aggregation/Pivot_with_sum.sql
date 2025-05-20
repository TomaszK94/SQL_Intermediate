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



SELECT
    product.categoryname,
    SUM(sales.quantity * sales.netprice * sales.exchangerate) AS net_revenue,
    SUM(CASE WHEN sales.orderdate BETWEEN '2022-01-01' AND '2022-12-31' THEN sales.quantity * sales.netprice * sales.exchangerate ELSE 0 END) AS total_revenue_2022,
    SUM(CASE WHEN sales.orderdate BETWEEN '2023-01-01' AND '2023-12-31' THEN sales.quantity * sales.netprice * sales.exchangerate ELSE 0 END) AS total_revenue_2023
FROM
    sales
LEFT JOIN product ON sales.productkey = product.productkey
GROUP BY
    product.categoryname
ORDER BY
    product.categoryname;