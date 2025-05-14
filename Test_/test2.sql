SELECT 
    s.orderdate,
    s.quantity * s.netprice * s.exchangerate AS net_revenue,
    c.givenname,
    c.surname,
    c.countryfull,
    c.continent,
    p.productkey,
    p.productname,
    p.categoryname,
    p.subcategoryname
FROM 
    sales AS s
LEFT JOIN customer AS c on s.customerkey = c.customerkey
LEFT JOIN product AS p on s.productkey = p.productkey
WHERE
    s.orderdate::date >= '2020-01-01'
LIMIT 100;