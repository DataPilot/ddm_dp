{{
    config(
        materialized='table'
    )
}}

WITH function AS (
    SELECT * FROM {{ source('linkedin_pages', 'function') }}
),
followers_by_function AS (
    SELECT * FROM {{ source('linkedin_pages', 'followers_by_function') }}
)

SELECT 
    function.id AS Function_ID,
    function.name AS Job_Function,
    followers_by_function._organization_entity_urn AS Organization_URN,
    followers_by_function.follower_counts_organic_follower_count AS Organic_Followers,
    followers_by_function.follower_counts_paid_follower_count AS Paid_Followers
    
FROM 
    function
JOIN 
    followers_by_function
ON 
   function.id = followers_by_function.function_id
