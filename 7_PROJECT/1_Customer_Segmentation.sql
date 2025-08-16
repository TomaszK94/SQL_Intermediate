WITH customer_ltv AS (
    SELECT 
        customerkey,
        cleaned_name,
        SUM(total_net_revenue) AS total_ltv
    FROM
        cohort_analysis
    GROUP BY
        customerkey,
        cleaned_name
    ORDER BY   
        customerkey
), customer_segments AS (
    SELECT 
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS ltv_25th_percentile,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS ltv_75th_percentile
    FROM
        customer_ltv
)

SELECT
    c.*
FROM
    customer_ltv c