SELECT
    customerkey,
    COUNT(*) AS total_orderds,
    ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) AS total_orders_row_num
FROM
    sales
GROUP BY
    customerkey
LIMIT 50;