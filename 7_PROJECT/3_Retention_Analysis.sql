WITH customer_last_purchase AS(
    SELECT 
        customerkey,
        cleaned_name,
        orderdate,
        ROW_NUMBER() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS rn,
        first_purchase_date
    FROM
        cohort_analysis
)

SELECT 
    customerkey,
    cleaned_name,
    orderdate AS last_purchase_date,
    CASE
        WHEN orderdate < '2024-04-20'::DATE - INTERVAL '6 months' THEN 'Churned'
        ELSE 'Active' 
        END AS customer_status 
FROM
    customer_last_purchase
WHERE
    rn = 1 AND
    first_purchase_date < '2024-04-20'::DATE - INTERVAL '6 months'




-- Checking last active database orderdate
SELECT
    MAX(orderdate)
FROM
    sales