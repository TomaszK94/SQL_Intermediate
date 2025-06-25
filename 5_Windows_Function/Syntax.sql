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
LIMIT 20;

--------

SELECT
    customerkey,
    orderkey,
    linenumber,
    (quantity * netprice * exchangerate) AS net_revenue,
    AVG(quantity * netprice * exchangerate) OVER(PARTITION BY orderkey) AS avg_net_revenue_all_orders
FROM
    sales
ORDER BY
    customerkey
LIMIT 20;


--------


SELECT
    customerkey,
    orderdate,
    (quantity * netprice * exchangerate) AS net_revenue,
    ROW_NUMBER() OVER (
        PARTITION BY customerkey 
        ORDER BY (quantity * netprice * exchangerate) DESC
        ) AS order_rank,
    SUM(quantity * netprice * exchangerate) OVER(
        PARTITION BY customerkey
    ) AS customer_total,
    (quantity * netprice * exchangerate) / SUM(quantity * netprice * exchangerate) OVER (PARTITION BY customerkey) * 100 AS percent_of_total
FROM
    sales
ORDER BY
    customerkey,
    orderdate
LIMIT 20;