/* 
Multiple WHEN Clauses in a single Case Block:

SELECT 
    CASE
        WHEN contidion1 THEN column
        WHEN condition2 THEN column
        ELSE column
    END AS alias
FROM 
    table_name;
*/

/* CATEGORIZE

- Mutliple High Value Items --> quantity >=2 AND  netprice >= 100
- Single High Value Item --> netprice >= 100
- Multiple Standard Items --> quantity >= 2 
- Single Standard Item --> Otherwise 

*/


SELECT 
    orderdate,
    quantity,
    netprice,
    CASE 
        WHEN quantity >=2 AND netprice >= 100 THEN 'Mutliple High Value Items'
        WHEN netprice >= 100 THEN 'Single High Value Item'
        WHEN quantity >=2 THEN 'Multiple Standard Items'
        ELSE 'Single Standard Item' 
    END AS order_value
FROM
    sales
LIMIT 50;