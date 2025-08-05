WITH yearly_cohort AS(
    SELECT
        customerkey,
        EXTRACT(YEAR FROM MIN(orderdate)) AS cohort_year,
        SUM(quantity * netprice * exchangerate) AS customer_ltv
    FROM
        sales
    GROUP BY
        customerkey
), cohort_sumary AS (
    SELECT
        cohort_year,
        customerkey,
        customer_ltv,
        AVG(customer_ltv) OVER(PARTITION BY cohort_year) AS avg_cohort_ltv
    FROM
        yearly_cohort
    ORDER BY
        cohort_year,
        customerkey
)

SELECT DISTINCT
    cohort_year,
    avg_cohort_ltv
FROM
    cohort_sumary
ORDER BY
    cohort_year