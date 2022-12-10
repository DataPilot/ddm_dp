
{{
    config(
        materialized='table'
    )
}}

SELECT 
        DATE(CURRENT_TIMESTAMP) AS today_date , SUM(Spent) AS Spent,AVG(Spent) AS AVG_Spent, SUM(approximate_unique_impressions) AS approximate_unique_impressions,
        AVG(CPM) AS AVG_CPM,SUM(clicks) AS clicks, SUM(impressions) AS impressions, AVG(impressions) AS AVG_impressions,
        AVG(CTR) AS AVG_CTR,AVG(CPC) AS AVG_CPC , SUM(conversions) AS conversions, AVG(conversions) AS AVG_conversions,
        SUM(Cost_per_conversion) AS Total_Cost_per_conversion, SUM(leads) AS leads,SUM(CPL) AS Total_CPL,SUM(comments) AS comments, 
        SUM(likes) AS likes,SUM(shares) AS shares, SUM(total_engagements) AS total_engagements


FROM 
        {{ ref('li_ads_campaigns_statistics_transf')}}
