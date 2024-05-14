{{ config(materialized='table') }}

WITH source AS (
    SELECT
        id,
        _fivetran_deleted,
        _fivetran_synced,
        at_time,
        billable,
        description,
        duration,
        end_time,
        folder_id,
        list_id,
        source,
        space_id,
        start_time,
        tags,
        task_id,
        task_name,
        task_status,
        task_status_color,
        task_status_order_index,
        task_status_type,
        task_url,
        team_id,
        user_id,
        w_id
    FROM {{ source('clickup_latest', 'time_entry') }}
)

SELECT
    id,
    FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP_MILLIS(at_time)) AS at_time,
    billable,
    description,
    -- Assuming 'duration' is in seconds, converting to hours.
    duration / 1000 AS duration,
    FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP_MILLIS(end_time)) AS end_time,
    folder_id,
    list_id,
    source,
    space_id,
    FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP_MILLIS(start_time)) AS start_time,
    tags,
    task_id,
    task_name,
    task_status,
    task_status_color,
    task_status_order_index,
    task_status_type,
    task_url,
    team_id,
    user_id,
    w_id
FROM source
