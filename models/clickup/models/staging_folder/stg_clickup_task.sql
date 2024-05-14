{{ config(materialized='table') }}

WITH source AS (
    SELECT
        id,
        archived,
        creator_id,
        creator_username,
        custom_fields, -- Assuming JSON format, requires further transformation if needed
        name AS task_name,
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP_MILLIS(date_created)) AS date_created,
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP_MILLIS(due_date)) AS due_date,
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP_MILLIS(start_date)) AS start_date,
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP_MILLIS(date_done)) AS date_done,
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP_MILLIS(date_closed)) AS date_closed,
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP_MILLIS(date_updated)) AS date_updated,
        time_estimate / 1000 as time_estimate,
        time_spent / 1000 as time_spent,
        description,
        folder_id,
        list_id,
        order_index,
        priority,
        priority_color,
        priority_id,
        priority_order_index,
        project_id,
        space_id,
        status_color,
        status_order_index,
        status_status,
        status_type,
        team_id
     FROM {{ source('clickup_latest', 'task') }}  
    
)

SELECT * FROM source
ORDER BY date_created DESC
