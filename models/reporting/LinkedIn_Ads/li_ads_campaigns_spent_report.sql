
{{
    config(
        materialized='table'
    )
}}

SELECT 
        campaign_id, ROUND( CAST (Spent AS NUMERIC),2) AS Spent  
        

FROM 
        {{ ref('li_ad_campaigns_transf')}}

Order By 
    Spent DESC

    