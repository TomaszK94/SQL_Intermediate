SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY (s.quantity * s.netprice * s.exchangerate)) AS perc_25th
FROM 
sales AS s 
WHERE
    orderdate BETWEEN '2022-01-01' AND '2023-12-31'