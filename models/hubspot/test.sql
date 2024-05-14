{{ config(materialized="table") }}

SELECT *
FROM {{ source('bq_ddm_hubspot', 'Contacts') }}


-- {{ ref('int_hubspot__contact_merge_adjust') }} AS int_hubspot__contact_merge_adjust
