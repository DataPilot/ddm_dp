{{ config(materialized='table') }}

WITH source AS (
    SELECT
        id,
        _fivetran_deleted,
        _fivetran_synced,
        archived,
        time_tracking_enabled,
        color,
        name,
        team_id
    FROM {{ source('clickup_latest', 'space') }}
),

transformed AS (
    SELECT
        id,
        archived,
        color,
        name AS space_name,
        team_id,
        time_tracking_enabled,
        CASE
            WHEN name IN ('Lulusar', 'CGIAR', '7 Knots Digital', 'Homemade Method', 'We Guide', 'Growth Shop', 'Zenfinex', 'Data Analytics and AI- Mudasser', 'KPMG-MoMRAH', 'Clutch Performance', 'Triple Tree Analytics', 'ELM', 'Pakistan Single Window', 'Bridgitt', 'Finbot') THEN 'Paid'
            ELSE 'Unpaid'
        END AS project_status
    FROM source
)

SELECT * FROM transformed