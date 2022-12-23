
{{
    config(
        materialized='table'
    )
}}

with li_ads_ad_analytics_by_campaign_raw as (

    SELECT 
        campaign_id, CAST(ROUND(SUM(cost_in_usd),2) AS NUMERIC) AS Spent

    FROM 
        {{ ref('li_ads_ad_analytics_by_campaign_raw')}}

    Group By campaign_id
    
)

SELECT *
FROM li_ads_ad_analytics_by_campaign_raw
