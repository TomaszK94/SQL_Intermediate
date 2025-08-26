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

``` SQL
-- Table 
WITH customer_ltv AS (
    SELECT 
        customerkey,
        cleaned_name,
        SUM(total_net_revenue) AS total_ltv
    FROM
        cohort_analysis
    GROUP BY
        customerkey,
        cleaned_name
    ORDER BY   
        customerkey
), customer_segments AS (
    SELECT 
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS ltv_25th_percentile,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS ltv_75th_percentile
    FROM
        customer_ltv
)
SELECT
    c.*,
    CASE
        WHEN c.total_ltv < cs.ltv_25th_percentile THEN '1 - LOW-VALUE'
        WHEN c.total_ltv BETWEEN cs.ltv_25th_percentile AND cs.ltv_75th_percentile  THEN '2 - MID-VALUE'
        ELSE '3 - HIGH-VALUE'
        END AS customer_segment
FROM
    customer_ltv c,
    customer_segments cs
ORDER BY
    customer_segment DESC,
    total_ltv DESC,
    customerkey
```
``` SQL
-- Statistics
WITH customer_ltv AS (
    SELECT 
        customerkey,
        cleaned_name,
        SUM(total_net_revenue) AS total_ltv
    FROM
        cohort_analysis
    GROUP BY
        customerkey,
        cleaned_name
    ORDER BY   
        customerkey
), customer_segments AS (
    SELECT 
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS ltv_25th_percentile,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS ltv_75th_percentile
    FROM
        customer_ltv
), segment_values AS(
    SELECT
        c.*,
        CASE
            WHEN c.total_ltv < cs.ltv_25th_percentile THEN '1 - LOW-VALUE'
            WHEN c.total_ltv BETWEEN cs.ltv_25th_percentile AND cs.ltv_75th_percentile  THEN '2 - MID-VALUE'
            ELSE '3 - HIGH-VALUE'
            END AS customer_segment
    FROM
        customer_ltv c,
        customer_segments cs
    ORDER BY
        customer_segment DESC,
        total_ltv DESC,
        customerkey
)
SELECT 
    customer_segment,
    SUM(total_ltv) AS total_revenet_by_segment,
    COUNT(customerkey) AS customer_count,
    SUM(total_ltv) / COUNT(customerkey) AS avg_ltv
FROM
    segment_values
GROUP BY 
    customer_segment
ORDER BY
    customer_segment
```

### 2. Customer Revenue by Cohort

**Query:** [Cohort Analysis](7_PROJECT/2_Customer_Revenue_By_Cohort.sql)

### 3. Customer Retention

**Query:** [Retention Analysis](7_PROJECT/3_Retention_Analysis.sql)

## Strategic Recommendations

## Technical Details

- **Database:** `PostgreSQL`
- **Analysis Tools:** `pgAdmin`, `Visual Studio Code`, `Dbeaver`