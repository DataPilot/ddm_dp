{{
    config(
        materialized='table'
    )
}}

with google_analytics_internal_raw as (

    SELECT 
        *

    FROM 
        {{ ref('google_analytics_internal_raw')}}

    

    
    
)

SELECT
    *
FROM google_analytics_internal_raw
Where source = 'hubspot' OR
    source = 'hs_email' OR
    source = 'email' OR
    source = 'Email' OR
    source = 'EMAIL'
