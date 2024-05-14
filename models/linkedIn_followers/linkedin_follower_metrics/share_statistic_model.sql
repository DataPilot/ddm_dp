{{
    config(
        materialized='table'
    )
}}

SELECT
    day,
    organization_entity,
    click_count AS Click_Count,
    like_count AS Like_Count,
    share_count AS Share_Count,
    comment_count AS Comment_Count,
    comment_mentions_count AS Comment_Mentions_Count,
    share_mentions_count AS Share_Mentions_Count,
    (CASE WHEN engagement IS NOT NULL THEN engagement ELSE 0 END) / 100 AS Engagement_Rate,
    impression_count AS Impression_Count,
    unique_impressions_count AS Unique_Impressions_Count,
    CASE
        WHEN impression_count > 0 THEN click_count / impression_count
        ELSE 0
    END AS Click_Through_Rate,
    click_count + like_count + share_count + comment_count AS Total_Engagement
FROM {{ source('linkedin_pages','time_bound_share_statistic') }}
WHERE organization_entity = 'urn:li:organization:13417981'


ORDER BY day DESC

