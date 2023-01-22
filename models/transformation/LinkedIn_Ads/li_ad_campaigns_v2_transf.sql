
{{
    config(
        materialized='table'
    )
}}

with li_ads_ad_analytics_by_campaign_raw as (

    SELECT 
        campaign_id , day,CAST((cost_in_usd) AS NUMERIC) AS Spent, approximate_unique_impressions, CAST( IF ((approximate_unique_impressions) > 0,(cost_in_usd)/(approximate_unique_impressions),0) AS NUMERIC) AS CPM, clicks, impressions,
        CAST( IF ((impressions) > 0,(clicks)/(impressions),0) AS NUMERIC) AS CTR,CAST( IF ((clicks) > 0,(cost_in_usd)/(clicks),0)AS NUMERIC) AS CPC ,external_website_conversions AS conversions,CAST (IF ((one_click_leads) > 0,(cost_in_usd)/(one_click_leads),0) AS NUMERIC ) AS Cost_per_conversion,
        one_click_leads AS leads, CAST(IF ((one_click_leads) > 0,(cost_in_usd)/(one_click_leads),0) AS NUMERIC) AS CPL,comments, CAST (likes AS NUMERIC) AS likes,shares, total_engagements, 1 AS number 


    FROM 
        {{ ref('li_ads_ad_analytics_by_campaign_raw')}}

   
    
)

SELECT *
FROM li_ads_ad_analytics_by_campaign_raw

