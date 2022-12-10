
{{
    config(
        materialized='table'
    )
}}

SELECT 
        campaign_id, Spent

FROM 
        {{ ref('li_ad_campaigns_transf')}}

Order By 
    Spent DESC

    