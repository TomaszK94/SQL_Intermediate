-- Create Main View

CREATE VIEW cohort_analysis AS 
    WITH customer_revenue AS(
        SELECT 
            s.customerkey,
            s.orderdate,
            SUM(s.exchangerate * s.quantity * s.netprice) AS total_net_revenue,
            COUNT(s.orderkey),
            c.countryfull,
            c.age,
            c.givenname,
            c.surname
        FROM
            sales s
        LEFT JOIN customer c 
            ON c.customerkey = s.customerkey
        GROUP BY
            s.customerkey,
            s.orderdate,
            c.countryfull,
            c.age,
            c.givenname,
            c.surname
    )
    SELECT 
        cr.*,
        MIN(cr.orderdate) OVER(PARTITION BY cr.customerkey) AS first_purchase_date,
        EXTRACT(YEAR FROM MIN(cr.orderdate) OVER(PARTITION BY cr.customerkey)) AS cohort_year
    FROM
        customer_revenue cr


-- View Column Rename

ALTER VIEW cohort_analysis RENAME COLUMN count to num_orders


-- RENAME TEST

SELECT *
FROM
    cohort_analysis


-- TEST View functions

SELECT 
    cohort_year,
    SUM(total_net_revenue)
FROM 
    cohort_analysis
GROUP BY
    cohort_year
ORDER BY
    cohort_year DESC;