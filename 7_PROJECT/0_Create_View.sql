SELECT 
    s.customerkey,
    s.orderdate,
    SUM(s.exchangerate * s.quantity * s.netprice) AS total_net_revenue,
    COUNT(s.orderkey)
FROM
    sales s
GROUP BY
    s.customerkey,
    s.orderdate