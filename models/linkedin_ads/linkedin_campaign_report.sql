{{
    config(
        materialized='table'
    )
}}

SELECT
    cgh.id AS campaign_group_id,
    cgh.name AS campaign_group_name,
    ch.id AS campaign_id,
    ch.name AS campaign_name,
    ch.type AS campaign_type,
    ch.status AS campaign_status,
    ch.objective_type AS campaign_objective_type,
    ch.format AS campaign_format,
    ch.locale_country,
    ch.locale_language,
    ch.daily_budget_amount AS campaign_daily_budget,
    ch.unit_cost_amount AS bid_cost_amount,
    ch.created_time AS campaign_created_time,
    ch.last_modified_time AS campaign_last_modified_time,
    ch.run_schedule_start AS campaign_schedule_start,
    ch.run_schedule_end AS campaign_schedule_end,
    SUM(ch.unit_cost_amount) OVER (PARTITION BY cgh.id) AS total_bid_amount_per_campaign_group
FROM
    {{ source('linkedin_ads', 'campaign_group_history') }} cgh
JOIN
    {{ source('linkedin_ads', 'campaign_history') }} ch
ON
    cgh.id = ch.campaign_group_id
WHERE
    ch.account_id = 504347554
GROUP BY
    cgh.id, cgh.name, ch.id, ch.name, ch.type, ch.status, ch.objective_type, 
    ch.format, ch.locale_country, ch.locale_language, ch.daily_budget_amount, 
    ch.unit_cost_amount, ch.created_time, ch.last_modified_time, 
    ch.run_schedule_start, ch.run_schedule_end
ORDER BY
    cgh.id, ch.id
