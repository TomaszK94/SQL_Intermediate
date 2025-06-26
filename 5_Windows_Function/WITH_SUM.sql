SELECT
    orderdate,
    orderkey * 10 + linenumber AS order_line_number,
    (quantity * netprice * exchangerate) AS net_revenue
FROM
    sales
LIMIT 20;
