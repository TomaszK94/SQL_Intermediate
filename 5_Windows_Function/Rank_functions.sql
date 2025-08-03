SELECT
    customerkey,
    COUNT(*) AS total_orderds,
    ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) AS total_orders_row_num,
    RANK() OVER(ORDER BY COUNT(*) DESC) AS total_orders_rank,
    DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS total_orders_dense_rank
FROM
    sales
GROUP BY
    customerkey
LIMIT 50;