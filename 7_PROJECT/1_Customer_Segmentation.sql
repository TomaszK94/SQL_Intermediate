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