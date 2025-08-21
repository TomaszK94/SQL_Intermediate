SELECT 
    customerkey,
    cleaned_name,
    orderdate,
    ROW_NUMBER() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS rn,
    first_purchase_date
FROM
    cohort_analysis