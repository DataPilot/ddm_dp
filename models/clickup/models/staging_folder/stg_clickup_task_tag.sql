{{ config(materialized='table') }}  -- or 'table', depending on your preference and project conventions

WITH source AS (
    SELECT
        _fivetran_id,
        _fivetran_deleted,
        _fivetran_synced,
        creator,
        name AS tag_name,  -- Renaming for clarity
        tag_bg,
        tag_fg,
        task_id
    FROM {{ source('clickup_latest', 'task_tag') }}  -- Referencing the source defined in your src.yml
    
)

SELECT
    creator,
    tag_name,
    tag_bg,
    tag_fg,
    task_id
FROM source