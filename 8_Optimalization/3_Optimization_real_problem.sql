EXPLAIN ANALYZE
    WITH customer_revenue AS(
        SELECT 
            s.customerkey,
            s.orderdate,
            SUM(s.quantity * s.netprice / s.exchangerate) AS total_net_revenue,
            COUNT(s.orderkey) AS num_orders,
            c.countryfull,
            c.age,
            CONCAT(TRIM(c.givenname),' ', TRIM(c.surname)) AS cleaned_name
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