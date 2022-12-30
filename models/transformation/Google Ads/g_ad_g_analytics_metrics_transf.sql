{{
    config(
        materialized='table'
    )
}}

with g_ad_campaign_history_raw as (

    SELECT 
        CAST(id AS STRING) AS id,updated_at AS ua_1,_fivetran_synced AS ft2, ad_serving_optimization_status, advertising_channel_subtype, advertising_channel_type,
        base_campaign_id, end_date, experiment_type, final_url_suffix, name as Camp_Name, optimization_score, payment_mode, serving_status,
        start_date, status as s1, tracking_url_template, vanity_pharma_display_url_mode, vanity_pharma_text, video_brand_safety_suitability

    FROM 
        {{ ref('g_ad_campaign_history_raw')}}

    
    
),


google_analytics_fivetran_table_ad_adwords_campaigns_raw as (

    SELECT 
        _fivetran_id AS f_ID_1,date,profile,_fivetran_synced as ft1, ad_clicks, ad_cost,CAST (adwords_campaign_id AS STRING) as id,
        bounce_rate, cpc, goal_completions_all, goal_conversion_rate_all, goal_value_all, sessions, users
    FROM
         {{ ref('google_analytics_fivetran_table_ad_adwords_campaigns_raw')}}


),

final as (

    Select
        *

    From google_analytics_fivetran_table_ad_adwords_campaigns_raw

    left join g_ad_campaign_history_raw using (id)



)

SELECT 
    * 
FROM 
    final

