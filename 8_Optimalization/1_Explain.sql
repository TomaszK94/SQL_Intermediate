/*
Explain: Displays the execution plan of a SQL query, showing how PostrgreSQL will execute it.

SYNTAX:

EXPLAIN 
SELECT
    column
FROM 
    table;


Explain Analyze: Execute the query and provides actual execution times, row estimates, and other runtime details.

SYNTAX:

EXPLAIN ANALYZE 
SELECT
    column
FROM
    table;

*/

EXPLAIN
SELECT *
FROM
    sales
