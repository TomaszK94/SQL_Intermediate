# Sales Analysis
## Overview

Analyzing customer behavior, retention patterns, and lifetime value in an e-commerce business to enhance customer loyalty and maximize revenue growth.

## Business Questions

1. `Customer Segmentation:` Identifying our highest-value customer segments.

2. `Cohort Analysis:` Evaluating revenue contributions across different customer groups.

3. `Retention Analysis:` Determining which customers have become inactive or lapsed.

## Clean Up Data

- Consolidated sales and customer data into revenue metrics
- Identified first purchase dates to enable cohort analysis
- Developed a unified view combining transactions with customer details

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

- Segmented customers by total lifetime value (LTV)
- Classified customers into High-, Mid-, and Low-value groups
- Computed key performance metrics, including total revenue

**Query:** [Customer Segmentation](7_PROJECT/1_Customer_Segmentation.sql)

``` SQL
-- Table 
WITH customer_ltv AS (
    SELECT 
        customerkey,
        cleaned_name,
        ROUND(SUM(total_net_revenue)) AS total_ltv
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

| Customerkey  | Cleaned Name      | Total LTV | Customer segment |
|--------------|-------------------|-----------|------------------|
| 552225       | Janina Unger      | 68 448$   | 3 - HIGH-VALUE   |
| 17743963     | Patricia Dalton   | 65 432$   | 3 - HIGH-VALUE   |
| 1151535      | Dylan Brennan     | 63 399$   | 3 - HIGH-VALUE   |
| ...          | ...               | ...       |   ...            |
| 390134       | Edward Stjohn     | 5 576$    | 2 - MID-VALUE    |
| 1357959      | Marianne Sweeney  | 5 576$    | 2 - MID-VALUE    |
| ...          | ...               | ...       |  ...             |
| 55123        | Lachlan Chipper   | 836$      | 1 - LOW-VALUE    |
| 126130       | Zachary Melbourne | 836$      | 1 - LOW-VALUE    |
| ...          | ...               |  ...      |   ...            |

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
    ROUND(SUM(total_ltv)) AS total_revenet_by_segment,
    COUNT(customerkey) AS customer_count,
    ROUND(SUM(total_ltv) / COUNT(customerkey)) AS avg_ltv
FROM
    segment_values
GROUP BY 
    customer_segment
ORDER BY
    customer_segment
```

| Customer segment | Total Revenue by segment | Customer Count | AVG LTV |
|------------------|--------------------------|----------------|---------|
| 1 - LOW-VALUE    | 4 298 367$               | 12372          | 347$    |
| 2 - MID-VALUE    | 66 367 810$              | 24743          | 2 682$  |
| 3 - HIGH-VALUE   | 135 606 969$             | 12372          | 10 961$ |

**Visualization:**
![Customer Segmentation](Resources/1.%20Customer%20Segmentation.jpg)

**Conlusion:**
- The high-value segment (25% of customers) contributes 66% of total revenue ($135,6M).

- The mid-value segment (50% of customers) delivers 32% of revenue ($66,4M).

- The low-value segment (25% of customers) generates just 2% of revenue ($4,3M).

**Insights:**
- High-Value (66% of revenue): Introduce a premium membership program `VIP customers`, as the loss of even a single customer has a major revenue impact.

- Mid-Value (32% of revenue): Develop personalized promotions and upgrade paths, unlocking a potential revenue increase.

- Low-Value (2% of revenue): Launch re-engagement initiatives and price-sensitive offers to drive higher purchase frequency.

### 2. Customer Revenue by Cohort

- Monitored revenue and customer counts across cohorts
- Grouped cohorts by the year of first purchase
- Examined revenue trends at the cohort level

**Query:** [Cohort Analysis](7_PROJECT/2_Customer_Revenue_By_Cohort.sql)

``` SQL
SELECT
    cohort_year,
    COUNT(DISTINCT customerkey) AS total_customers,
    ROUND(SUM(total_net_revenue) ) AS total_revenue,
    ROUND(SUM(total_net_revenue) / COUNT(DISTINCT customerkey)) AS customer_revenue
FROM
    cohort_analysis
GROUP BY
    cohort_year;
```

| Cohort Year | Total Customers | Total Revenue | Revenue by Customer |
|-------------|-----------------|---------------|---------------------|
|    2015     | 2 825           | 15 870 339$   | 5 618$              |
|    2016     | 3 397           | 18 770 034$   | 5 525$              |
|    2017     | 4 068           | 22 689 804$   | 5 578$              |
|    2018     | 7 446           | 37 093 402$   | 4 982$              |
|    2019     | 7 755           | 36 564 592$   | 4 715$              |
|    2020     | 3 031           | 11 763 692$   | 3 881$              |
|    2021     | 4 663           | 18 429 387$   | 3 952$              |
|    2022     | 9 010           | 28 419 483$   | 3 154$              |
|    2023     | 5 890           | 13 951 294$   | 2 369$              |
|    2024     | 1 402           |  2 721 120$   | 1 941$              |

**Visualization:**
![Customer Revenue By Cohort](Resources/2.%20Customer%20Revenue.jpg)

### 3. Customer Retention

- Detected customers at risk of churn
- Examined patterns in recent purchase behavior
- Calculated customer-level performance metrics

**Query:** [Retention Analysis](7_PROJECT/3_Retention_Analysis.sql)

``` SQL
-- Table
WITH customer_last_purchase AS(
    SELECT 
        customerkey,
        cleaned_name,
        orderdate,
        ROW_NUMBER() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS rn,
        first_purchase_date
    FROM
        cohort_analysis
)
SELECT 
    customerkey,
    cleaned_name,
    orderdate AS last_purchase_date,
    CASE
        WHEN orderdate < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months' THEN 'Churned'
        ELSE 'Active' 
        END AS customer_status 
FROM
    customer_last_purchase
WHERE
    rn = 1 AND
    first_purchase_date < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months'
```

| Customerkey | Cleaned Name       | Last Purchase Date | Customer Status |
|-------------|--------------------|--------------------|-----------------|
| 15          | Julian McGuigan    | 2021-03-08         | Churned         |
| 180         | Gabriel Bosanquet  | 2023-08-28         | Churned         |
| 185         | Gabrielle Castella | 2019-06-01         | Churned         |
| 243         | Maya Atherton      | 2016-05-19         | Churned         |
| 387         | Tahlia Underwood   | 2023-11-16         | Active          |
| ...         | ...                | ...                | ...             |

``` SQL
-- Statistics
WITH customer_last_purchase AS(
    SELECT 
        customerkey,
        cleaned_name,
        orderdate,
        ROW_NUMBER() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS rn,
        first_purchase_date
    FROM
        cohort_analysis
), churned_customers AS(
SELECT 
    customerkey,
    cleaned_name,
    orderdate AS last_purchase_date,
    CASE
        WHEN orderdate < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months' THEN 'Churned'
        ELSE 'Active' 
        END AS customer_status 
FROM
    customer_last_purchase
WHERE
    rn = 1 AND
    first_purchase_date < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months'
)
SELECT 
    customer_status,
    ROUND(COUNT(customerkey) / SUM(COUNT(customerkey)) OVER() * 100, 2) AS percentage_customers
FROM
    churned_customers
GROUP BY 
    customer_status
```

| Customer Status | Percentage Customers |
|-----------------|----------------------|
| Active          | 9,47%                | 
| Churned         | 90,53%               |

**Visualization:**
![Churned vs Active](Resources/3.%20Churned%20vs%20Active%20Customers%20ALL.jpg)

``` SQL
-- Statistics by Cohort Year
WITH customer_last_purchase AS(
    SELECT 
        customerkey,
        cleaned_name,
        orderdate,
        ROW_NUMBER() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS rn,
        first_purchase_date,
        cohort_year
    FROM
        cohort_analysis
), churned_customers AS(
SELECT 
    customerkey,
    cleaned_name,
    orderdate AS last_purchase_date,
    CASE
        WHEN orderdate < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months' THEN 'Churned'
        ELSE 'Active' 
        END AS customer_status,
    cohort_year
FROM
    customer_last_purchase
WHERE
    rn = 1 AND
    first_purchase_date < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months'
)
SELECT 
    customer_status,
    cohort_year,
    ROUND(COUNT(customerkey) / SUM(COUNT(customerkey)) OVER(PARTITION BY cohort_year) * 100, 2) AS percentage_customers
FROM
    churned_customers
GROUP BY 
    cohort_year,
    customer_status
```

| Customer Status | Cohort Year | Percentage Customers | 
|-----------------|-------------|----------------------|
| Active          | 2015        | 8,39%                |
| Churned         | 2015        | 91,61%               |
| Active          | 2016        | 9,16%                |
| Churned         | 2016        | 90,84%               |
| Active          | 2017        | 9,46%                |
| Churned         | 2017        | 90,54%               |
| Active          | 2018        | 9,45%                |
| Churned         | 2018        | 90,55%               |
| Active          | 2019        | 8,86%                |
| Churned         | 2019        | 91,14%               |
| Active          | 2020        | 9,34%                |
| Churned         | 2020        | 90,66%               |
| Active          | 2021        | 9,48%                |
| Churned         | 2021        | 90,52%               |
| Active          | 2022        | 10,40%               |
| Churned         | 2022        | 89,60%               |
| Active          | 2023        | 9,64%                |
| Churned         | 2023        | 90,36%               |

**Visualization:**
![Churned vs Active By Cohort](Resources/3.%20Churned%20vs%20Active%20Customers%20By%20Cohort.jpg)

## Strategic Recommendations

## Technical Details

- **Database:** `PostgreSQL`
- **Analysis Tools:** `pgAdmin`, `Visual Studio Code`, `Dbeaver`
- **Visualization** `Power BI`