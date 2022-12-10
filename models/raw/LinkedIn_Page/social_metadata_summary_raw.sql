{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM {{ source('bq_ddm_LI_p', 'social_metadata_summary') }} 

