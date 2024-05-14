{{
    config(
        materialized='table'
    )
}}

SELECT
    day,
    organization_entity,
    follower_gains_organic_follower_gain + follower_gains_paid_follower_gain AS Followers_Gain
FROM {{ source('linkedin_pages','time_bound_follower_statistic') }}
WHERE organization_entity = 'urn:li:organization:13417981'

ORDER BY day DESC
