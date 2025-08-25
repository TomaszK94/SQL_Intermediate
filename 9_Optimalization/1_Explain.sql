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


EXPLAIN ANALYZE
SELECT *
FROM
    sales


/*

Seq Scan - PostgreSQL is doing a sequential scan (no index used).
cost - An arbitary unit for cost (... basically made up units specific to PostgreSQL).
rows - Estimated number of rows
width - Estimated row size in bytes.

*/ 


EXPLAIN ANALYZE
SELECT 
    customerkey,
    SUM(quantity * netprice / exchangerate) AS net_revenue
FROM
    sales
WHERE 
    orderdate >= '2024-01-01'
GROUP BY 
    customerkey