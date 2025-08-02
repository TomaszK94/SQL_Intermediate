SELECT 
    ROW_NUMBER() OVER(
        PARTITION BY
            orderdate
        ORDER BY
            orderdate,
            orderkey,
            linenumber            
        ) AS row_number,
        *
FROM
    sales
LIMIT 50;