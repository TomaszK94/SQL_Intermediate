SELECT
    customerkey,
    AVG(quantity * netprice / exchangerate) AS net_revenue,
    COUNT(*) OVER (PARTITION BY customerkey) AS total_order
FROM
    sales
GROUP BY
    customerkey

/*
WINDOW FUNCTIONS RUN AFTER GROUP BY !!!
NOT RECOMENDED COMBINE THEM.
BETTER USE CTE FIRST TO APPLY WINDOW FUNCTION THEN PERFORM GROUP BY
*/

-- FIX PREVIOUS QUERY
WITH customer_order AS(
SELECT
    customerkey,
    (quantity * netprice / exchangerate) AS order_value,
    COUNT(*) OVER (PARTITION BY customerkey) AS total_order
FROM
    sales
)

SELECT 
    customerkey,
    total_order,
    AVG(order_value) AS net_revenue
FROM
    customer_order
GROUP BY
    customerkey,
    total_order
ORDER BY
    customerkey