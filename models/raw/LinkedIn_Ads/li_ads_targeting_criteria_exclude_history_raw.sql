
{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM {{ source('bq_ddm_LI_ad_ft', 'targeting_criteria_exclude_history') }}