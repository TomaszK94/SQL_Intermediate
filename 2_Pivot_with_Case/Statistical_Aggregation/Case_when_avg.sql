SELECT
    product.categoryname,
    AVG(sales.quantity * sales.netprice * sales.exchangerate) AS avg_revenue,
    AVG(CASE WHEN sales.orderdate BETWEEN '2022-01-01' AND '2022-12-31' THEN (sales.quantity * sales.netprice * sales.exchangerate) END) AS avg_revenue_2022,
    AVG(CASE WHEN sales.orderdate BETWEEN '2023-01-01' AND '2023-12-31' THEN (sales.quantity * sales.netprice * sales.exchangerate) END) AS avg_revenue_2023
FROM
    sales
LEFT JOIN product ON sales.productkey = product.productkey
GROUP BY
    product.categoryname
ORDER BY
    product.categoryname; 