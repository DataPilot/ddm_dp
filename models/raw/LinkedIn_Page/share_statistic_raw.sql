{{
    config(
        materialized='table'
    )
}}

SELECT
    _fivetran_id,_fivetran_synced AS sync_time_1,_organization_entity_urn,_share_entity_urn,click_count,comment_count,
    engagement,impression_count,like_count,share_count
FROM {{ source('bq_ddm_LI_p', 'share_statistic') }} 

