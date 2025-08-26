# Sales Analysis
## Overview
## Business Questions
## Clean Up Data

**Query:** [Create View](7_PROJECT/0_Create_View.sql)

``` SQL
CREATE VIEW cohort_analysis AS 
    WITH customer_revenue AS(
        SELECT 
            s.customerkey,
            s.orderdate,
            SUM(s.quantity * s.netprice / s.exchangerate) AS total_net_revenue,
            COUNT(s.orderkey) AS num_orders,
            MAX(c.countryfull) AS countryfull, 
            MAX(c.age) AS age, 
            MAX(CONCAT(TRIM(c.givenname),' ', TRIM(c.surname))) AS cleaned_name 
        FROM
            sales s
        INNER JOIN customer c  
            ON c.customerkey = s.customerkey
        GROUP BY
            s.customerkey,
            s.orderdate  
    )
    SELECT 
        cr.*,
        MIN(cr.orderdate) OVER(PARTITION BY cr.customerkey) AS first_purchase_date,
        EXTRACT(YEAR FROM MIN(cr.orderdate) OVER(PARTITION BY cr.customerkey)) AS cohort_year
    FROM
        customer_revenue cr;
```

## Analysis

### 1. Customer Segmentation

**Query:** [Customer Segmentation](7_PROJECT/1_Customer_Segmentation.sql)

### 2. Customer Revenue by Cohort

**Query:** [Cohort Analysis](7_PROJECT/2_Customer_Revenue_By_Cohort.sql)

### 3. Customer Retention

**Query:** [Retention Analysis](7_PROJECT/3_Retention_Analysis.sql)

## Strategic Recommendations

## Technical Details

- **Database:** `PostgreSQL`
- **Analysis Tools:** `pgAdmin`, `Visual Studio Code`, `Dbeaver`