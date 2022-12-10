
{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM {{ source('bq_ddm_LI_p', 'comment_history') }} 


