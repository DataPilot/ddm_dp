
{{
    config(
        materialized='table'
    )
}}

SELECT 
        *

FROM 
        {{ ref('li_ads_campaigns_statistics_transf')}}

