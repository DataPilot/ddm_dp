{{ config(materialized='table') }}

WITH source AS (
    SELECT
        id AS team_id,
        _fivetran_deleted AS is_deleted,
        _fivetran_synced AS last_synced,
        avatar AS avatar_url,
        color AS display_color,
        name AS team_name 
        
    FROM {{ source('clickup_latest', 'team') }}
)

SELECT
    team_id,
    avatar_url,
    display_color,
    team_name

FROM source
WHERE team_name = 'Data Pilot'
AND team_id = 42044676
