{{
    config(
        materialized='table'
    )
}}

WITH country AS (
    SELECT * FROM {{ source('linkedin_pages', 'country') }}
),
followers_by_country AS (
    SELECT * FROM {{ source('linkedin_pages', 'followers_by_country') }}
)

SELECT 
    country.id AS Country_Code,
    country.name AS Country_Name,
     country.country_group AS Country_Group,
    followers_by_country._organization_entity_urn AS Organization_URN,
    followers_by_country.follower_counts_organic_follower_count AS Organic_Followers,
    followers_by_country.follower_counts_paid_follower_count AS Paid_Followers
    
FROM 
    country 
JOIN 
    followers_by_country 
ON 
    country.id = followers_by_country.country_id

