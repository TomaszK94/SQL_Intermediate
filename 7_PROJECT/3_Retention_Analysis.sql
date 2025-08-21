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
    orderdate
FROM
    customer_last_purchase
WHERE
    rn = 1