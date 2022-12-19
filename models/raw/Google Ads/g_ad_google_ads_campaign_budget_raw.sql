{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM {{ source('bq_ddm_G_ad', 'google_ads_campaign_budget') }} 