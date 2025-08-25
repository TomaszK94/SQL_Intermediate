
WITH percentile AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY (s.quantity * s.netprice / s.exchangerate)) AS perc_25th,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY (s.quantity * s.netprice / s.exchangerate)) AS perc_75th
    FROM 
        sales AS s 
    WHERE
        orderdate BETWEEN '2022-01-01' AND '2023-12-31'
)

SELECT
    product.categoryname,
    CASE
        WHEN (sales.quantity * sales.netprice / sales.exchangerate) <= percentile.perc_25th THEN '3 - LOW'
        WHEN (sales.quantity * sales.netprice / sales.exchangerate) >= percentile.perc_75th THEN '1 - HIGH'
        ELSE '2 - MEDIUM'
    END AS revenu_tier,
    SUM(sales.quantity * sales.netprice / sales.exchangerate) AS total_revenue
FROM
    sales
LEFT JOIN 
    product ON sales.productkey = product.productkey,
    percentile
GROUP BY
    product.categoryname,
    revenu_tier
ORDER BY
    product.categoryname,
    revenu_tier;