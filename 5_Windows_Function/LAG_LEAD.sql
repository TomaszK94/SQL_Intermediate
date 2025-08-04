WITH monthly_revenue AS(
    SELECT 
        TO_CHAR(orderdate, 'YYYY-MM') AS month,
        SUM(exchangerate * quantity * netprice) AS net_revenue
    FROM
        sales
    WHERE
        EXTRACT(YEAR FROM orderdate) = 2023
    GROUP BY 
        month
    ORDER BY
        month
)

SELECT
    *,
    FIRST_VALUE(net_revenue) OVER(ORDER BY month)
FROM 
    monthly_revenue