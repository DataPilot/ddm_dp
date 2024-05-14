{{
    config(
        materialized='table'
    )
}}

SELECT
    day,
    _organization_entity_urn,
    first_degree_size AS Follower_Count

FROM {{ source('linkedin_pages', 'total_follower_statistic') }}
WHERE _organization_entity_urn = 'urn:li:organization:13417981'

ORDER BY day DESC


