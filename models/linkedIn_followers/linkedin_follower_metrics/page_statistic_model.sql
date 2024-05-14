{{
    config(
        materialized='table'
    )
}}

SELECT
    day,
    organization_entity,
    (all_page_views) AS Total_Page_Views,
    (all_unique_page_views) AS Total_Unique_Page_Views
    
FROM {{ source('linkedin_pages', 'time_bound_page_statistic') }}
WHERE organization_entity = 'urn:li:organization:13417981'

ORDER BY day DESC
