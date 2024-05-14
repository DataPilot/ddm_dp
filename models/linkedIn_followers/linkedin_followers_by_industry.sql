{{
    config(
        materialized='table'
    )
}}

WITH industry AS (
    SELECT * FROM {{ source('linkedin_pages', 'industry') }}
),
followers_by_industry AS (
    SELECT * FROM {{ source('linkedin_pages', 'followers_by_industry') }}
),

joined_industry AS (
    SELECT 
        industry.id AS Industry_ID,
        industry.name AS Industry_Name,
        followers_by_industry._organization_entity_urn AS Organization_URN,
        followers_by_industry.follower_counts_organic_follower_count AS Organic_Followers,
        followers_by_industry.follower_counts_paid_follower_count AS Paid_Followers
    
    FROM 
        industry
    JOIN 
        followers_by_industry
    ON 
        industry.id = followers_by_industry.industry_id
)

SELECT * FROM joined_industry
