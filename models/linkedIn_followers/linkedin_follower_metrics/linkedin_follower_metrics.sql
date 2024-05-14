{{
    config(
        materialized='table'
    )
}}

SELECT DISTINCT
    all_days.day,
    COALESCE(fgm.organization_entity, psm.organization_entity, ssm.organization_entity) AS organization_entity,
    fgm.Followers_Gain,
    psm.Total_Page_Views,
    psm.Total_Unique_Page_Views,
    ssm.Click_Count,
    ssm.Like_Count,
    ssm.Share_Count,
    ssm.Comment_Count,
    ssm.Comment_Mentions_Count,
    ssm.Share_Mentions_Count,
    ssm.Engagement_Rate,
    ssm.Impression_Count,
    ssm.Unique_Impressions_Count,
    ssm.Click_Through_Rate,
    ssm.Total_Engagement
FROM
    (SELECT DISTINCT day FROM {{ ref('follower_gain_model') }}
    UNION ALL
    SELECT DISTINCT day FROM {{ ref('page_statistic_model') }}
    UNION ALL
    SELECT DISTINCT day FROM {{ ref('share_statistic_model') }}
    ) AS all_days
LEFT JOIN {{ ref('follower_gain_model') }} fgm ON all_days.day = fgm.day
LEFT JOIN {{ ref('page_statistic_model') }} psm ON all_days.day = psm.day
LEFT JOIN {{ ref('share_statistic_model') }} ssm ON all_days.day = ssm.day
ORDER BY all_days.day DESC
