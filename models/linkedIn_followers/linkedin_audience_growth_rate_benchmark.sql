{{
    config(
        materialized='table'
    )
}}

WITH monthly_growth_data AS (
  SELECT
    DATE_TRUNC(CAST(day AS DATE), MONTH) AS Month,
    MIN(first_degree_size) AS start_of_month_followers,
    MAX(first_degree_size) AS end_of_month_followers
  FROM {{ source('linkedin_pages', 'total_follower_statistic') }}
  GROUP BY DATE_TRUNC(CAST(day AS DATE), MONTH)
),

calculated_growth AS (
  SELECT
    month,
    ((end_of_month_followers - start_of_month_followers) / NULLIF(start_of_month_followers, 0)) * 100 AS monthly_growth_rate_percentage
  FROM monthly_growth_data
),

industry_benchmarks AS (
  SELECT DATE '2023-07-01' AS MONTH, 2.02 AS Benchmark UNION ALL
  SELECT DATE '2023-08-01', 2.17 UNION ALL
  SELECT DATE '2023-09-01', 1.58 UNION ALL
  SELECT DATE '2023-10-01', 2.39 UNION ALL
  SELECT DATE '2023-11-01', 1.27 UNION ALL
  SELECT DATE '2023-12-01', 1.27
)

SELECT
  c.month,
  c.monthly_growth_rate_percentage,
  b.benchmark,
  (c.monthly_growth_rate_percentage - b.benchmark) AS Difference,
  CASE 
    WHEN c.monthly_growth_rate_percentage >= b.benchmark THEN 'KPI Met'
    ELSE 'KPI Not Met'
  END AS kpi_status,
  ABS(c.monthly_growth_rate_percentage - b.benchmark) AS Deviation_from_kpi
FROM calculated_growth c
LEFT JOIN industry_benchmarks b ON c.month = b.month
ORDER BY c.month
