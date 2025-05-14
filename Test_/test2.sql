SELECT *
FROM 
    sales AS s
LEFT JOIN customer AS c on s.customerkey = c.customerkey
LEFT JOIN product AS p on s.productkey = p.productkey
WHERE
    s.orderdate::date >= '2020-01-01'