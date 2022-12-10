
{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM {{ source('bq_ddm_LI_ad_ft', 'account_history') }} 




