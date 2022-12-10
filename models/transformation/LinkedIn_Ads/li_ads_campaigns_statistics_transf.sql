
{{
    config(
        materialized='table'
    )
}}


with li_ads_ad_analytics_stats_campaign_raw as (

    SELECT 
        campaign_id,Date(Min(day)) AS start_date, SUM(cost_in_usd) AS Spent, SUM(approximate_unique_impressions) AS approximate_unique_impressions,
        SUM(cost_in_usd)/SUM(approximate_unique_impressions)*1000 AS CPM, SUM(clicks) AS clicks, SUM(impressions) AS impressions,
        SUM(clicks) / SUM(impressions) AS CTR,SUM(cost_in_usd)/SUM(clicks) AS CPC , SUM(external_website_conversions) AS conversions,
        IF  (SUM(external_website_conversions) > 0, SUM(cost_in_usd)/SUM(external_website_conversions),0) AS Cost_per_conversion, SUM(COALESCE(one_click_leads,0)) AS leads, 
        IF (SUM(one_click_leads) > 0,SUM(cost_in_usd)/SUM(one_click_leads),0) AS CPL,SUM(comments) AS comments, 
        SUM(COALESCE(likes,0)) AS likes,SUM(shares) AS shares, SUM(total_engagements) AS total_engagements

    FROM 
        {{ ref('li_ads_ad_analytics_by_campaign_raw')}}

    Group By campaign_id
    
)

SELECT *
FROM li_ads_ad_analytics_stats_campaign_raw
