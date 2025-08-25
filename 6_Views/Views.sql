/*
Views:
- Simplifies complex queries by stroing them as reusable, named objects.
- Ensures consistency and readability when multiple queries rely on the same logic.
- Enhances security by restricting access to specific rows/columns.
- Improves maintainability by centralizing changes to the query logic.

SYNTAX:

CREATE VIEW view_name AS 
SELECT
    column1,
    column2,
    column3
FROM 
    table_name

*/

-- Create
CREATE VIEW daily_revenue AS
SELECT
    orderdate,
    SUM(netprice * quantity / exchangerate) AS total_revenue
FROM
    sales
GROUP BY
    orderdate
ORDER BY
    orderdate DESC;

-- Query
SELECT *
FROM
    daily_revenue


-- DELETE
DROP VIEW daily_revenue