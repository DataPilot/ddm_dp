
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
        id,updated_at AS ua_1,_fivetran_synced AS ft2, ad_serving_optimization_status, advertising_channel_subtype, advertising_channel_type,
        base_campaign_id, end_date, experiment_type, final_url_suffix, name as Camp_Name, optimization_score, payment_mode, serving_status,
        start_date, status as s1, tracking_url_template, vanity_pharma_display_url_mode, vanity_pharma_text, video_brand_safety_suitability
    FROM
         {{ ref('g_ad_campaign_history_raw')}}


),

g_ad_campaign_criterion_history_raw as (

    SELECT 
        campaign_id as id ,id as id_1 ,updated_at AS ua_2  ,_fivetran_synced AS ft3, age_range_type,bid_modifier,carrier_country_code,carrier_name,content_label_type,
        device_type,display_name,geo_target_constant_id,status AS s2,type
    FROM
         {{ ref('g_ad_campaign_criterion_history_raw')}}


),

g_ad_geo_target_raw as (

    SELECT 
        id AS id_1, _fivetran_synced AS ft4, canonical_name, country_code, name AS Country_name, parent_geo_target_id, status AS s3, target_type
    FROM
         {{ ref('g_ad_geo_target_raw')}}


),

final as (

    Select
        *

    From g_ad_campaign_stats_raw

    left join g_ad_campaign_history_raw using (id)

    left join g_ad_campaign_criterion_history_raw using(id)

    left join g_ad_geo_target_raw using(id_1)

)

SELECT 
    * 
FROM 
    final
