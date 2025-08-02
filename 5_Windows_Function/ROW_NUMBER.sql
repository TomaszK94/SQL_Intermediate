SELECT 
    ROW_NUMBER() OVER(
        ORDER BY
            orderdate,
            orderkey,
            linenumber            
        ) AS row_number,
        *
FROM
    sales
LIMIT 50;