SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY (s.quantity * s.netprice * s.exchangerate)) AS median
FROM 
    sales AS s 
WHERE
    orderdate BETWEEN '2022-01-01' AND '2023-12-31';

SELECT
    product.categoryname,
    SUM(CASE WHEN (sales.quantity * sales.netprice * sales.exchangerate) < 398 
            AND sales.orderdate BETWEEN '2022-01-01' AND '2022-12-31'
        THEN (sales.quantity * sales.netprice * sales.exchangerate) END) AS low_net_revenue_2022,
    SUM(CASE WHEN (sales.quantity * sales.netprice * sales.exchangerate) >= 398 
            AND sales.orderdate BETWEEN '2022-01-01' AND '2022-12-31'
        THEN (sales.quantity * sales.netprice * sales.exchangerate) END) AS high_net_revenue_2022,
    SUM(CASE WHEN (sales.quantity * sales.netprice * sales.exchangerate) < 398 
            AND sales.orderdate BETWEEN '2023-01-01' AND '2023-12-31'
        THEN (sales.quantity * sales.netprice * sales.exchangerate) END) AS low_net_revenue_2023,
    SUM(CASE WHEN (sales.quantity * sales.netprice * sales.exchangerate) >= 398 
            AND sales.orderdate BETWEEN '2023-01-01' AND '2023-12-31'
        THEN (sales.quantity * sales.netprice * sales.exchangerate) END) AS high_net_revenue_2023
FROM
    sales
LEFT JOIN product ON sales.productkey = product.productkey
GROUP BY
    product.categoryname
ORDER BY
    product.categoryname; 