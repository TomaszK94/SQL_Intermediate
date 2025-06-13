/*
DATE_PART() - extract specific components (y,m,d) from date or timestamp --> float number

SYNTAX:
DATE_PART('UNIT', source)

DATE_PART('year', orderdate)
*/


SELECT
    orderdate,
    DATE_PART('year', orderdate) AS order_year,
    DATE_PART('month', orderdate) AS order_month,
    DATE_PART('day', orderdate) AS order_day
FROM
    sales
ORDER BY
    RANDOM()
LIMIT 10;