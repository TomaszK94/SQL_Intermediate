SELECT
    customerkey,
    orderdate,
    EXTRACT(YEAR FROM MIN(orderdate) OVER(PARTITION BY customerkey)) AS cohor_year
FROM
    sales
ORDER BY
    customerkey
LIMIT 10;

-----

SELECT DISTINCT
    customerkey,
    EXTRACT(YEAR FROM MIN(orderdate) OVER(PARTITION BY customerkey)) AS cohor_year
FROM
    sales

-----

WITH yearly_cohort AS(
SELECT DISTINCT
    customerkey,
    EXTRACT(YEAR FROM MIN(orderdate) OVER(PARTITION BY customerkey)) AS cohort_year
FROM
    sales
)

SELECT
    y.cohort_year,
    EXTRACT(YEAR FROM s.orderdate) AS purchase_year,
    SUM(s.quantity * s.netprice * s.exchangerate) AS net_revenue
FROM
    sales s
LEFT JOIN yearly_cohort y ON s.customerkey = y.customerkey
GROUP BY
    y.cohort_year,
    purchase_year