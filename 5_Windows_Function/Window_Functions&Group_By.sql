SELECT
    customerkey,
    AVG(quantity * netprice * exchangerate) AS net_revenue,
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
