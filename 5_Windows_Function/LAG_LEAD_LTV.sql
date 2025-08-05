SELECT
    customerkey,
    EXTRACT(YEAR FROM MIN(orderdate)) AS cohort_year,
    SUM(quantity * netprice * exchangerate) AS customer_ltv
FROM
    sales
GROUP BY
    customerkey