WITH monthly_sales AS( 
    SELECT
        TO_CHAR(orderdate, 'YYYY-MM') AS month,
        SUM(quantity * netprice / exchangerate) AS net_revenue
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
    month,
    net_revenue,
    AVG(net_revenue) OVER (
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS net_revenue_all_month,
    AVG(net_revenue) OVER (
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS net_revenue_all_before_and_current
FROM
    monthly_sales


----

WITH monthly_sales AS(
    SELECT 
        TO_CHAR(orderdate, 'YYYY-MM') AS month,
        SUM(quantity * netprice / exchangerate) AS net_revenue
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
    month,
    net_revenue,
    FIRST_VALUE(net_revenue) OVER(ORDER BY month) AS first_month_revenue,
    LAST_VALUE(net_revenue) OVER(
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_month_revenue,
    NTH_VALUE(net_revenue, 3) OVER(
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS third_month_revenue
FROM 
    monthly_sales