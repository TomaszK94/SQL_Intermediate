SELECT
    orderdate,
    orderkey * 10 + linenumber AS order_line_number,
    (quantity * netprice * exchangerate) AS net_revenue,
    SUM(quantity * netprice * exchangerate) OVER(PARTITION BY orderdate) AS daily_revenue,
    (quantity * netprice * exchangerate) * 100 / SUM(quantity * netprice * exchangerate) OVER(PARTITION BY orderdate) AS percent_daily
FROM
    sales
ORDER BY
    orderdate,
    percent_daily DESC
LIMIT 100;
