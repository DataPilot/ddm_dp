{{ config(materialized='table') }}

WITH source AS (
    SELECT
        id,
        _fivetran_deleted,
        _fivetran_synced,
        archived,
        hidden,
        name,
        order_index,
        override_statuses,
        permission_level,
        space_id,
        statuses,
        task_count 
    FROM {{ source('clickup_latest', 'folder') }}
)

SELECT
    id AS folder_id,
    archived,
    hidden,
    name AS folder_name,
    order_index,
    override_statuses,
    permission_level,
    space_id,
    statuses,
    task_count
FROM source
