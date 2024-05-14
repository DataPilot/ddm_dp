{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM {{ source('bq_ddm_G_ad', 'google_ads_adgroups_metrics') }} 