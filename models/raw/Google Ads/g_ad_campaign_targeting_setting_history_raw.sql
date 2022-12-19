{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM {{ source('bq_ddm_G_ad', 'campaign_targeting_setting_history') }} 