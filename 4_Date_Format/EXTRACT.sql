/*
EXTRACT() - extract specific components (y,m,d) from date or timestamp

SYNTAX:
EXTRACT(unit FROM source)

EXTRACT(YEAR FROM orderdate)
*/


SELECT
    orderdate,
    EXTRACT(YEAR FROM orderdate) AS order_year,
    EXTRACT(MONTH FROM orderdate) AS order_month,
    EXTRACT(DAY FROM orderdate) AS order_day
FROM
    sales
ORDER BY
    RANDOM()
LIMIT 10;