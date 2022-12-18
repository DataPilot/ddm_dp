
{{
    config(
        materialized='table'
    )
}}

SELECT
    id,last_modified_time as lmt_1,_fivetran_synced AS sync_time_2,author,client_application,container_entity,content_certification_record,created_actor,
    created_time,deleted_actor,deleted_time,distribution_distributed_via_follow_feed,distribution_external_distribution_channels,
    distribution_feed_distribution,first_published_at,last_modified_actor,lifecycle_state,response_context_parent,response_context_root,specific_content_primary_landing_page_url,
    specific_content_share_commentary_attributes,specific_content_share_commentary_inferred_locale, LEFT (specific_content_share_commentary_text, 150)  AS   specific_content_share_commentary_text,
    specific_content_share_media_category,target_audience_targeted_entities,version_tag,visibility
FROM {{ source('bq_ddm_LI_p', 'ugc_post_history') }} 

