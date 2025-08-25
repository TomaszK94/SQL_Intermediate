SELECT
    orderdate,
    orderkey * 10 + linenumber AS order_line_number,
    (quantity * netprice / exchangerate) AS net_revenue,
    SUM(quantity * netprice / exchangerate) OVER(PARTITION BY orderdate) AS daily_revenue,
    (quantity * netprice / exchangerate) * 100 / SUM(quantity * netprice / exchangerate) OVER(PARTITION BY orderdate) AS percent_daily
FROM
    sales
ORDER BY
    orderdate,
    percent_daily DESC
LIMIT 100;

-- ORGANIZED BY CTE USAGE

SELECT *,
    ROUND((100 * net_revenue::numeric / daily_revenue::numeric), 2) AS daily_percent
FROM(
    SELECT
        orderdate,
        orderkey * 10 + linenumber AS order_line_number,
        (quantity * netprice / exchangerate) AS net_revenue,
        SUM(quantity * netprice / exchangerate) OVER(PARTITION BY orderdate) AS daily_revenue
    FROM
        sales
) AS revenue_by_day
ORDER BY
    orderdate,
    daily_percent DESC
LIMIT 100;
