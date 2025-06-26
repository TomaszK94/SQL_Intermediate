SELECT
    orderdate,
    orderkey,
    linenumber,
    (quantity * netprice * exchangerate) AS net_revenue
FROM
    sales
LIMIT 20;
