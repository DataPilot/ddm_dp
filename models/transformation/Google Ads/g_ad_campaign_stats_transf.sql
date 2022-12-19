
{{
    config(
        materialized='table'
    )
}}

with g_ad_campaign_stats_raw as (

    SELECT 
        *

    FROM 
        {{ ref('g_ad_campaign_stats_raw')}}

    
    
)

SELECT *
FROM g_ad_campaign_stats_raw
