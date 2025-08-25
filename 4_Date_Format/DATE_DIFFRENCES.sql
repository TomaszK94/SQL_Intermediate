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
    s.orderdate,
    p.categoryname,
    SUM(s.quantity * s.netprice / s.exchangerate) AS net_revenue
FROM
    sales AS s
LEFT JOIN product AS p ON s.productkey = p.productkey
WHERE
    CURRENT_DATE - INTERVAL '5 years' <= orderdate
GROUP BY
    s.orderdate,
    p.categoryname
ORDER BY
    s.orderdate,
    p.categoryname;