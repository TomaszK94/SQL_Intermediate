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
    EXTRACT(YEAR FROM MIN(orderdate) OVER(PARTITION BY customerkey)) AS cohor_year
FROM
    sales
)

SELECT *
FROM
    sales s
LEFT JOIN yearly_cohort y ON s.customerkey = y.customerkey