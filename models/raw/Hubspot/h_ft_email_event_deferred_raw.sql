{{
    config(
        materialized='table'
    )
}}

SELECT
    *
FROM {{ source('bq_ddm_hubspot_fv', 'email_event_deferred') }} 