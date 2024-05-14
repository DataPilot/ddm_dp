{{
    config(
        materialized='table'
    )
}}

SELECT
    date AS Date, 
    page_path AS Page_Path,
    screen_page_views AS Page_Views,
    conversions AS Conversions,
    event_count AS Event_Count,
    new_users AS New_Users,
    total_revenue AS Total_Revenue,
    total_users AS Total_Users,
    user_engagement_duration AS User_Engagement_Duration

FROM 
{{source('google_analytics_4', 'ga_4_eng_pages')}}

ORDER BY date DESC
