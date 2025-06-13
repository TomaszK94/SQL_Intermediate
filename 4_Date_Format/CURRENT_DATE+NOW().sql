SELECT 
    CURRENT_DATE

SELECT 
    NOW()




SELECT
    CURRENT_DATE,
    EXTRACT(YEAR FROM orderdate) AS order_year,
    EXTRACT(YEAR FROM CURRENT_DATE) AS current_year,
    EXTRACT(YEAR FROM CURRENT_DATE) - 5 AS five_years,
    sales.orderdate,
    product.categoryname,
    SUM(sales.quantity * sales.netprice * sales.exchangerate) AS net_revenue
FROM
    sales
LEFT JOIN 
    product ON sales.productkey = product.productkey
WHERE
    EXTRACT(YEAR FROM CURRENT_DATE) - 5 <= EXTRACT(YEAR FROM orderdate)
GROUP BY
    sales.orderdate,
    product.categoryname
ORDER BY
    sales.orderdate,
    product.categoryname