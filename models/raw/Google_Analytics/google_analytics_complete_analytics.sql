{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM {{ source('bq_ddm_G_an_skyvia', 'CompleteAnalytics') }} 