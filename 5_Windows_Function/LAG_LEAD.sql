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
    FIRST_VALUE(net_revenue) OVER(ORDER BY month) AS first_month_revenue,
    LAST_VALUE(net_revenue) OVER(ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_month_revenue,
    NTH_VALUE(net_revenue, 3) OVER(ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_month_revenue
FROM 
    monthly_revenue



-- LAG() AND LEAD()
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
    LAG(net_revenue) OVER(ORDER BY month) AS previous_month_revenue,
    LEAD(net_revenue) OVER(ORDER BY month) AS next_month_revenue
FROM 
    monthly_revenue



-- MoM Growth
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
    LAG(net_revenue) OVER(ORDER BY month) AS previous_month_revenue,
    net_revenue - LAG(net_revenue) OVER(ORDER BY month) AS monthly_revenue_grow
FROM 
    monthly_revenue