/*
Using AND in a CASE WHEN Condition:

SELECT
    CASE WHEN condition1 AND condition2 THEN column END AS alias
FROM 
    table_name;
*/


-- "High Value Order" if quantity >=2 AND netprice >=50 ELSE Standard Order

SELECT 
    orderdate,
    quantity,
    netprice,
    CASE WHEN quantity >=2 AND netprice >= 50 THEN 'High Value Order'
        ELSE 'Standard Order' 
    END AS order_value
FROM
    sales
LIMIT 50;
