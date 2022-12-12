
{{
    config(
        materialized='table'
    )
}}

SELECT 
        DATE(CURRENT_TIMESTAMP) AS today_date , SUM(Spent) AS Spent,AVG(Spent) AS AVG_Spent,CAST(SUM(approximate_unique_impressions) AS NUMERIC) AS approximate_unique_impressions,
       ROUND( AVG(Spent)/AVG(impressions)*1000,2) AS AVG_CPM,SUM(clicks) AS clicks, SUM(impressions) AS impressions, ROUND(AVG(impressions),2) AS AVG_impressions,
        ROUND(SUM(clicks)/SUM(impressions),3) AS AVG_CTR, ROUND(SUM(Spent)/SUM(clicks),2) AS AVG_CPC , SUM(conversions) AS conversions,ROUND(AVG(conversions),2) AS AVG_conversions,
        SUM(Spent)/Sum(conversions) AS Total_Cost_per_conversion, SUM(leads) AS leads,SUM(Spent)/Sum(leads) AS Total_CPL,SUM(comments) AS comments, 
        SUM(likes) AS likes,SUM(shares) AS shares, SUM(total_engagements) AS total_engagements

FROM 
        {{ ref('li_ads_campaigns_statistics_transf')}}
