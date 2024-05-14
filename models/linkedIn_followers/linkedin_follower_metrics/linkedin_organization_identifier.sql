{{
    config(
        materialized='table'
    )
}}

SELECT
    organization_id,
    time_bound_page_statistic_id
FROM {{ source('linkedin_pages','organization_time_bound_page_statistic') }}
WHERE organization_id = 13417981

