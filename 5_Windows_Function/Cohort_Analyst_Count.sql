/*

COUNT - Counts the values, DISTINCT can be added to get the unique count.

Syntax:

SELECT
    COUNT() OVER(
        PARTITION BY partition_expression
        ) AS window_column_allias
FROM 
    table_name

*/

WITH yearly_cohort AS(
SELECT DISTINCT
    customerkey,
    EXTRACT(YEAR FROM (MIN(orderdate) OVER (PARTITION BY customerkey))) AS cohort_year,
    EXTRACT(YEAR FROM orderdate) AS purchase_year
FROM
    sales
)

SELECT DISTINCT
    cohort_year,
    purchase_year,
    COUNT(customerkey) OVER (PARTITION BY cohort_year, purchase_year) AS number_of_customers

FROM
    yearly_cohort
ORDER BY
    cohort_year,
    purchase_year;