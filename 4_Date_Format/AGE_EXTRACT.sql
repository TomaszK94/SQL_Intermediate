-- EXAMPLE
SELECT AGE('2025-01-23', '2025-01-01')
-- AGE --> Interval we cannot make any operation likes + - 


SELECT
EXTRACT(DAY FROM AGE('2025-06-23', '2025-01-01')) - 10

