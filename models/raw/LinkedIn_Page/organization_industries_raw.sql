{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM {{ source('bq_ddm_LI_p', 'organization_industries') }} 

