
{{
    config(
        materialized='table'
    )
}}


with li_ad_campaigns_transf as (

    SELECT 
        *,campaign_id as id
    FROM
         {{ ref('li_ad_campaigns_transf')}}

),


li_ads_campaign_history_raw as (

    SELECT 
        *
    FROM
         {{ ref('li_ads_campaign_history_raw')}}


),

final as (

    Select
        *

    From li_ad_campaigns_transf

    left join li_ads_campaign_history_raw using (id)

)

SELECT 
    * 
FROM 
    final





