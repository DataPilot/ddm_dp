{{ config(materialized='table') }}

WITH task_details AS (
    SELECT
        t.username,
        t.space_name,
        t.project_status,
        t.task_name,
        t.tags_and_billability,
        t.billability_status,
        t.date_created,
        t.date_updated,
        -- Assuming 'time_spent' is in milliseconds, converting it to hours.
        t.time_spent / 3600000.0 AS time_spent_hours
    FROM {{ ref('int_task') }} AS t
)

SELECT
    username,
    space_name,
    project_status,
    task_name,
    tags_and_billability,
    DATE(date_created) AS date_created,
    DATE(date_updated) AS date_updated,
    time_spent_hours
FROM task_details
WHERE 
billability_status = 'Billable' AND
project_status = 'Paid'

