{{
    config(
        materialized='table'
    )
}}


SELECT
    customer_id,
    date,
    ad_group_id,
    ad_id,
    ad_network_type,
    campaign_id,
    device,
    interaction_event_types,
    impressions,
    clicks,
    conversions,
    conversions_value,
    video_views,
    interactions,
    CASE
        WHEN interactions >= 1 THEN (conversions / interactions) * 100
        ELSE NULL
    END AS conversion_rate,
    (clicks / impressions) * 100 AS ctr,
    cost_micros / 1000000.0 AS cost,
    view_through_conversions,
    active_view_impressions,
    active_view_measurability,
    active_view_measurable_cost_micros / 1000000.0 AS active_view_measurable_cost,
    active_view_measurable_impressions,
    active_view_viewability

FROM
     {{ source('google_ads', 'ad_stats') }}
