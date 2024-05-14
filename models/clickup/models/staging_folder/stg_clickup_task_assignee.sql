{{ config(materialized='table') }}

WITH source AS (
    SELECT
        task_id,
        id,
        _fivetran_deleted,
        _fivetran_synced
    FROM {{ source('clickup_latest', 'task_assignee') }}
)

SELECT
    id,
    task_id
FROM source
