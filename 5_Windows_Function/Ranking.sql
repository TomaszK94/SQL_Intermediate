/*
ORDER BY
ORDER BY: Orders rows within each partition for the function.
ORDER BY can be ordered DESC or ASC 
SYNTAX:

SELECT
    window_function() OVER(
        PARTITION BY partition_expression
        ORDER BY column_name -- DESC or ASC
    ) AS window_column_allias
FROM
    table_name;

*/

SELECT
    customerkey,
    orderdate,
    (quantity * netprice * exchangerate) AS net_revenue,
    COUNT(*) OVER (
        PARTITION BY customerkey
        ORDER BY orderdate
    ) AS running_order_count,
    AVG(quantity * netprice * exchangerate) OVER (
        PARTITION BY customerkey
        ORDER BY orderdate
    ) AS running_avg_revenue
FROM
    sales