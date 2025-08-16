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
    c.*,
    CASE
        WHEN c.total_ltv < cs.ltv_25th_percentile THEN '1 - LOW-VALUE'
        WHEN c.total_ltv BETWEEN cs.ltv_25th_percentile AND cs.ltv_75th_percentile  THEN '2 - MID-VALUE'
        ELSE '3 - HIGH-VALUE'
        END AS customer_segment
FROM
    customer_ltv c,
    customer_segments cs
ORDER BY
    customer_segment DESC,
    total_ltv DESC,
    customerkey