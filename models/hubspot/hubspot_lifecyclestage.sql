{{ config(materialized="table") }}

SELECT
    int_hubspot__contact_merge_adjust.*,
    contact.property_lifecyclestage
FROM {{ ref('int_hubspot__contact_merge_adjust') }} AS int_hubspot__contact_merge_adjust
LEFT JOIN {{ source('hubspot', 'contact') }} AS contact ON int_hubspot__contact_merge_adjust.contact_id = contact.id