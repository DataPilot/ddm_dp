
{{
    config(
        materialized='table'
    )
}}

with g_ad_campaign_stats_raw as (

    SELECT 
        _fivetran_id, customer_id, date,_fivetran_synced as ft1, active_view_impressions,active_view_measurability,active_view_measurable_cost_micros,
        active_view_measurable_impressions,active_view_viewability,ad_network_type,base_campaign,clicks,conversions,conversions_value,
        cost_micros,device,id,impressions,interaction_event_types,interactions,view_through_conversions

    FROM 
        {{ ref('g_ad_campaign_stats_raw')}}

    
    
),


g_ad_campaign_history_raw as (

    SELECT 
        id,updated_at,_fivetran_synced AS ft2, ad_serving_optimization_status, advertising_channel_subtype, advertising_channel_type,
        base_campaign_id, end_date, experiment_type, final_url_suffix, name, optimization_score, payment_mode, serving_status,
        start_date, status, tracking_url_template, vanity_pharma_display_url_mode, vanity_pharma_text, video_brand_safety_suitability
    FROM
         {{ ref('g_ad_campaign_history_raw')}}


),

final as (

    Select
        *

    From g_ad_campaign_stats_raw

    left join g_ad_campaign_history_raw using (id)

)

SELECT 
    * 
FROM 
    final

