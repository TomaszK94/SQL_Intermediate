SELECT
    customerkey,
    orderkey,
    linenumber,
    (quantity * netprice * exchangerate) AS net_revenue,
    AVG(quantity * netprice * exchangerate) OVER() AS avg_net_revenue_all_orders
FROM
    sales
ORDER BY
    customerkey
LIMIT 10;

