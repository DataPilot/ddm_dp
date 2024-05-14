{{
    config(
        materialized='table'
    )
}}

    SELECT 
    _fivetran_id,
    _fivetran_synced,
    _organization_entity_urn,
    follower_counts_organic_follower_count,
    follower_counts_paid_follower_count,
    REPLACE(staff_count_range, '_', ' ') as staff_count_range_cleaned
FROM 
    {{ source('linkedin_pages', 'followers_by_staff_count_range') }}
