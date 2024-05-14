WITH task_details AS (
    SELECT
        id,
        creator_id,
        task_name,
        status_status,
        date_updated,
        date_created,
        date_closed,
        team_id,
        space_id,
        project_id,
        time_estimate,
        time_spent
    FROM {{ ref('stg_clickup_task') }}
),

task_with_space AS (
    SELECT
        td.*,
        s.space_name,
        s.project_status
    FROM task_details td
    LEFT JOIN {{ ref('stg_clickup_space') }} s ON td.space_id = s.id  -- Using LEFT JOIN here
),

assignee_details AS (
    SELECT
        task_id,
        id AS user_id
    FROM {{ ref('stg_clickup_task_assignee') }}
),

team_member_details AS (
    SELECT
        user_id,
        username
    FROM {{ ref('stg_clickup_team_member') }}
),

task_tag_details AS (
    SELECT
        task_id,
        STRING_AGG(tag_name, ', ') AS tags  -- Aggregating tag names for each task
    FROM {{ ref('stg_clickup_task_tag') }}
    GROUP BY task_id
),

final_join_with_billability AS (
    SELECT
        tws.id AS task_id,
        tws.task_name,
        tws.status_status,
        tws.time_estimate,
        tws.time_spent,
        tws.date_updated,
        tws.date_created,
        tws.date_closed,
        tws.creator_id,
        tm.username,
        ad.user_id AS assignee_user_id,
        tt.tags,
        CASE
            WHEN tt.tags LIKE '%non-billable%' OR tt.tags LIKE '%unpaid%' THEN 'Non-Billable'
            ELSE 'Billable'
        END AS billability_status,
        CASE
            WHEN tt.tags IS NOT NULL THEN 
                CONCAT(
                    CASE
                        WHEN tt.tags LIKE '%non-billable%' OR tt.tags LIKE '%unpaid%' THEN 'Non-Billable'
                        ELSE 'Billable'
                    END,
                    CASE
                        WHEN TRIM(REPLACE(REPLACE(tt.tags, 'non-billable', ''), 'unpaid', '')) != '' THEN CONCAT(': ', TRIM(REPLACE(REPLACE(tt.tags, 'non-billable', ''), 'unpaid', '')))
                        ELSE ''
                    END
                )
            ELSE 
                CASE
                    WHEN tt.tags LIKE '%non-billable%' OR tt.tags LIKE '%unpaid%' THEN 'Non-Billable'
                    ELSE 'Billable'
                END
        END AS tags_and_billability,
        tws.space_name,
        tws.project_status
    FROM task_with_space tws
    LEFT JOIN assignee_details ad ON tws.id = ad.task_id  -- Ensuring tasks without assignees are included
    LEFT JOIN team_member_details tm ON ad.user_id = tm.user_id  -- Ensuring tasks are included even if the assignee is not a team member
    LEFT JOIN task_tag_details tt ON tws.id = tt.task_id  -- Ensuring tasks without tags are included
)

SELECT * FROM final_join_with_billability

