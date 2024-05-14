{{ config(materialized='table') }}

WITH source AS (
    SELECT
        team_id,
        user_id,
        _fivetran_deleted,
        _fivetran_synced,
        color,
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP_MILLIS(date_invited)) AS date_invited,
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP_MILLIS(date_joined)) AS date_joined,  
        email,
        initials,
        invited_by_id,
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP_MILLIS(last_active)) AS last_active,   
        profile_picture,
        role,
        username
    FROM {{ source('clickup_latest', 'team_member') }} 
)

SELECT
    team_id,
    user_id,
    username,
    initials,
    email,
    color,
    date_invited,
    date_joined,
    last_active,
    role

FROM source
WHERE team_id = 42044676
