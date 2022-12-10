
{{
    config(
        materialized='table'
    )
}}

SELECT 
        Count (DISTINCT campaign_id) AS total_campaigns

FROM 
        {{ ref('li_ad_campaigns_transf')}}



    