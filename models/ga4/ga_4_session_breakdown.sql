SELECT
    gc.date,
    gc.session_campaign_name,
    gs.session_source,
    gs.session_medium,
    gc.conversions AS campaign_conversions,
    gs.conversions AS source_medium_conversions,
    gc.engaged_sessions AS campaign_engaged_sessions,
    gs.engaged_sessions AS source_medium_engaged_sessions,
    gc.engagement_rate AS campaign_engagement_rate,
    gs.engagement_rate AS source_medium_engagement_rate,
    gc.event_count AS campaign_event_count,
    gs.event_count AS source_medium_event_count,
    gc.events_per_session AS campaign_events_per_session,
    gs.events_per_session AS source_medium_events_per_session,
    gc.sessions AS campaign_sessions,
    gs.sessions AS source_medium_sessions,
    gc.total_revenue AS campaign_total_revenue,
    gs.total_revenue AS source_medium_total_revenue,
    gc.total_users AS campaign_total_users,
    gs.total_users AS source_medium_total_users,
    gc.user_engagement_duration AS campaign_user_engagement_duration,
    gs.user_engagement_duration AS source_medium_user_engagement_duration
FROM
     {{ source('google_analytics_4', 'ga_4_ta_session_campaign')}} gc
JOIN
     {{ source('google_analytics_4', 'ga_4_ta_session_source_medium')}} gs
ON
    gc.date = gs.date
    
ORDER BY Date DESC
