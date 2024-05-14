{{
    config(
        materialized='table'
    )
}}

SELECT
    date AS Date,
    country AS Country,
    conversions AS Conversions,
    engaged_sessions AS Engaged_Sessions,
    engagement_rate AS Engagement_Rate,
    event_count AS Event_Count,
    new_users AS New_Users,
    total_revenue AS Total_Revenue,
    total_users AS Total_Users

FROM
    {{ source('google_analytics_4', 'ga_4_dem_country') }}

ORDER BY Date DESC