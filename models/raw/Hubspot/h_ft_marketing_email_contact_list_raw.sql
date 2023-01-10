{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM {{ source('bq_ddm_hubspot_fv', 'marketing_email_contact_list') }} 