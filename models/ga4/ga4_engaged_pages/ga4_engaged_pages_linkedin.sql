{{ config(materialized='table') }}

WITH engaged_pages AS (
    SELECT
        Date,
        Page_Path,
        -- Extract the first directory after the leading slash
        REGEXP_EXTRACT(Page_Path, r'^/([^/]+)/') AS Blog_Base,
        -- Extract the title part after '/blog/'
        REGEXP_EXTRACT(Page_Path, r'^/blog/(.+)') AS Blog_Title,
        Page_Views,
        Conversions,
        Event_Count,
        New_Users,
        Total_Revenue,
        Total_Users,
        User_Engagement_Duration
    FROM
        {{ ref('ga4_engaged_pages') }}
    WHERE
        Page_Path LIKE '/blog/%'
), 

traffic_sources AS (
    SELECT
        Date,
        Source,
        Medium
    FROM {{ ref('ga4_traffic_session_source_medium') }}
    WHERE Source IN ('linkedin', 'linkedin.com')
)

SELECT
    e.Date,
    e.Page_Path,
    e.Blog_Base,
    e.Blog_Title,
    t.Source,
    t.Medium,
    e.Page_Views,
    e.Conversions,
    e.Event_Count,
    e.New_Users,
    e.Total_Revenue,
    e.Total_Users,
    e.User_Engagement_Duration,
    
FROM engaged_pages e
JOIN traffic_sources t
    ON e.Date = t.Date

