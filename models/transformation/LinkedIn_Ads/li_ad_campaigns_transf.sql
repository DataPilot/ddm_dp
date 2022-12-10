
{{
    config(
        materialized='table'
    )
}}

with li_ads_ad_analytics_by_campaign_raw as (

    SELECT 
        campaign_id, SUM(cost_in_usd) AS Spent

    FROM 
        {{ ref('li_ads_ad_analytics_by_campaign_raw')}}

    Group By campaign_id
    
)

SELECT *
FROM li_ads_ad_analytics_by_campaign_raw
