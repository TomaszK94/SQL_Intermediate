CREATE TABLE data_jobs (
    id INT,
    job_title VARCHAR(30),
    is_real_job VARCHAR(10),
    salary INT
);

INSERT INTO data_jobs VALUES
(1, 'Data Analyst', 'yes', NULL),
(2, 'Data Scientist', NULL, 140000),
(3, 'Data Engineer', 'kinda', 120000);


SELECT *
FROM 
    data_jobs;

/*
COALESCE()

Return the first non-null value from a list of expressions.

SYNTAX:

SELECT 
    COALESCE(expression1, expression2, ..., default_value);


Used to replace NULL values with a default. Common in reporting and data cleaning,
 such as filtering missing values with a placeholder.

*/

SELECT
    job_title,
    COALESCE(is_real_job, 'no') AS is_real_job,
    salary
FROM
    data_jobs;

SELECT
    job_title,
    COALESCE(is_real_job, 'no') AS is_real_job,
    COALESCE(salary::TEXT, job_title) AS salary
FROM
    data_jobs;

/*
NULLIF()

Returns NULL if two expressions are equal; otherwise, return the first expression.

SYNTAX:

SELECT
    NULLIF(expression1, expression2);

Helps prevent division by zero by returning null instead of causing an error.
*/