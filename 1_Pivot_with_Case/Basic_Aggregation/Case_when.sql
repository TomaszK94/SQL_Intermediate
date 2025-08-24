SELECT 
    s.orderdate,
    s.quantity * s.netprice / s.exchangerate AS net_revenue,
    CASE WHEN s.quantity * s.netprice / s.exchangerate >= 1000 THEN 'HIGH' ELSE 'LOW' END AS revenue_rank,
    c.givenname,
    c.surname,
    c.countryfull,
    c.continent,
    p.productkey,
    p.productname,
    p.categoryname,
    p.subcategoryname
FROM 
    sales s
LEFT JOIN customer c ON s.customerkey = c.customerkey
LEFT JOIN product p ON s.productkey = p.productkey
WHERE
    orderdate::date >= '2020-01-01'
