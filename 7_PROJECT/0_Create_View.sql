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
    MIN(cr.orderdate) OVER(PARTITION BY cr.customerkey) AS first_purchase_date
FROM
    customer_revenue cr