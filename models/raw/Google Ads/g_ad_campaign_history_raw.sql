{{
    config(
        materialized='table'
    )
}}

SELECT
    id, updated_at, _fivetran_synced, ad_serving_optimization_status, advertising_channel_subtype, advertising_channel_type, base_campaign_id, customer_id, end_date,
    experiment_type, final_url_suffix, frequency_caps, name, optimization_score, payment_mode, serving_status, DATE(start_date)  AS start_date  , status,  tracking_url_template, vanity_pharma_display_url_mode,
    vanity_pharma_text, video_brand_safety_suitability
FROM {{ source('bq_ddm_G_ad', 'campaign_history') }} 