{{
    config(
        materialized='table'
    )
}}

with google_analytics_internal_raw as (

    SELECT 
        Date , AvgTimeOnPageS, BounceRate, PageTitle, PageViews, LandingPagePath, EntranceRate, TimeOnPageS, ExitRate, CAST (Users as numeric) AS Users, Keyword, SocialNetwork,
        SourceMedium, Campaign, Source, Medium


    FROM 
        {{ ref('google_analytics_internal_raw')}}

  
    
)

SELECT
    *
FROM google_analytics_internal_raw

