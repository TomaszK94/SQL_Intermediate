/*
SYNTAX:

SELECT
    window_function() OVER(
        PARTITION BY partition_expression
    ) AS window_column_alias
FROM
    table_name


OVER() - Defines the window for the function. It can include PARTITION BY and other functions.

PARTITION BY - Divides the results set into partitions. The function is then applied to each partition.

*/

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

