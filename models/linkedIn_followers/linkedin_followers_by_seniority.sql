{{
    config(
        materialized='table'
    )
}}
WITH seniority AS (
    SELECT * FROM {{ source('linkedin_pages', 'seniority') }}
),
followers_by_seniority AS (
    SELECT * FROM {{ source('linkedin_pages', 'followers_by_seniority') }}
)

SELECT 
    seniority.id AS Seniority_Level_ID,
    seniority.name AS Seniority_Level,
    followers_by_seniority._organization_entity_urn AS Organization_URN,
    followers_by_seniority.follower_counts_organic_follower_count AS Organic_Followers,
    followers_by_seniority.follower_counts_paid_follower_count AS Paid_Followers
    
FROM 
    seniority
JOIN 
    followers_by_seniority
ON 
    seniority.id = followers_by_seniority.seniority_id
