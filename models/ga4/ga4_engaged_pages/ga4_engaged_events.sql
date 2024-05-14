{{
    config(
        materialized='table'
    )
}}

SELECT
  _fivetran_id,
  date,
  property,
  event_name,
  SUM(event_count) AS total_event_count,
  ROUND(AVG(event_count_per_user), 2) AS avg_event_count_per_user,
  SUM(total_revenue) AS total_revenue,
  SUM(total_users) AS total_users,
  ROUND((SUM(event_count) * 100.0 / SUM(SUM(event_count)) OVER()), 2) AS percentage_of_events
FROM  {{ source('google_analytics_4', 'ga_4_eng_events')}}
GROUP BY _fivetran_id, date, property, event_name
ORDER BY date