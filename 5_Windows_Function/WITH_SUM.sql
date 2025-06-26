SELECT
    orderdate,
    orderkey * 10 + linenumber AS order_line_number,
    (quantity * netprice * exchangerate) AS net_revenue,
    SUM(quantity * netprice * exchangerate) OVER(PARTITION BY orderdate) AS daily_revenue
FROM
    sales
LIMIT 100;
