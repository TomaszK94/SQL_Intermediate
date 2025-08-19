/*

FUNDAMENTAL OPTIMIZATIONS:
- Avoid SELECT * - Retrieve only necessary columns.
- Use LIMIT for large datasets - Improve performance on large queries.
- Use WHERE instead of HAVING - Filter before aggregation for efficiency.


QUERY STRUCTURE AND EXECUTION PLAN OPTIMIZATIONS
- Use Query Execution Plans - Identify slow queries and optimize execution paths.
- Minimize GROUP BY Usage - Avoid unnecessary aggregations.
- Reduce JOINS when possible - Optimize relationships to prevent expensive joins.
- Optimize ORDER BY - Use indexed columns for sorting:

OPTIMIZE ORDER BY:
- Limit number of columns in ORDER BY clause.
- Avoid sorting on computed columns or function calls.
- Place most selective column first in ORDER BY clause (columns that filter out more rows should come first,
as this allows the database to eliminate more rows early in the sorting process)
- Use indexed columns for sorting to leverage existing database indexes.

*/
