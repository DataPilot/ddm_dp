{{
    config(
        materialized='table'
    )
}}

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

