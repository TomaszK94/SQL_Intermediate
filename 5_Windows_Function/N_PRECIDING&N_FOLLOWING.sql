WITH monthly_sales AS( 
    SELECT
        TO_CHAR(orderdate, 'YYYY-MM') AS month,
        SUM(quantity * netprice * exchangerate) AS net_revenue
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
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) AS net_revenue_preceding_1,
       AVG(net_revenue) OVER (
        ORDER BY month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS net_revenue_preceding_2,
       AVG(net_revenue) OVER (
        ORDER BY month
        ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
    ) AS net_revenue_preceding_3
FROM
    monthly_sales

---

WITH monthly_sales AS( 
    SELECT
        TO_CHAR(orderdate, 'YYYY-MM') AS month,
        SUM(quantity * netprice * exchangerate) AS net_revenue
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
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS net_revenue_3_months
FROM
    monthly_sales