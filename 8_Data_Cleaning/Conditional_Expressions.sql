/*
COALESCE()

Return the first non-null value from a list of expressions.

SYNTAX:

SELECT 
    COALESCE(expression1, expression2, ..., default_value);


Used to replace NULL values with a default. Common in reporting and data cleaning,
 such as filtering missing values with a placeholder.

*/





/*
NULLIF()

Returns NULL if two expressions are equal; otherwise, return the first expression.

SYNTAX:

SELECT
    NULLIF(expression1, expression2);

Helps prevent division by zero by returning null instead of causing an error.
*/