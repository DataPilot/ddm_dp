{{
    config(
        materialized='table'
    )
}}


SELECT
    date AS Date,
    session_source AS Session_Source,
    total_users AS Total_Users,
    sessions AS Sessions,
    engaged_sessions AS Engaged_Sessions,
    engagement_rate AS Engagement_Rate,
    event_count AS Event_Count,
    events_per_session AS Events_Per_Session,
    user_engagement_duration AS User_Engagement_Duration,
    conversions AS Conversions

FROM
    {{ source('google_analytics_4', 'ga_4_ta_session') }}

ORDER BY
    Date DESC
