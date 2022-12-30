
{{
    config(
        materialized='table'
    )
}}

with g_ad_google_ads_adgroups_metrics_raw as (

    SELECT 
        _fivetran_id, customer_id,date,_fivetran_synced as ft1, absolute_top_impression_percentage,ad_group_id,ad_id,
    all_conversions,average_cost,average_cpc,average_cpe,average_cpm,average_cpv,average_page_views,average_time_on_site,bounce_rate,
    campaign_id AS id,clicks,conversions,cost_micros,cost_per_all_conversions,cost_per_conversion,engagement_rate,engagements,impressions,
    interactions

    FROM 
        {{ ref('g_ad_google_ads_adgroups_metrics_raw')}}
    
    
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
        *,CAST (id AS STRING) AS id2

    From g_ad_google_ads_adgroups_metrics_raw

    left join g_ad_campaign_history_raw using (id)

)

SELECT 
    * 
FROM 
    final

