
{{
    config(
        materialized='table'
    )
}}


with share_statistic_raw as (

    SELECT 
       _fivetran_id,_fivetran_synced AS sync_time_1,_organization_entity_urn,_share_entity_urn as id ,click_count,comment_count,
        engagement,impression_count,like_count,share_count
       
       
        
    FROM
         {{ ref('share_statistic_raw')}}

),




ugc_post_history_raw as (

    SELECT 
        id,last_modified_time as lmt_1,_fivetran_synced AS sync_time_2,author,client_application,container_entity,content_certification_record,created_actor,
    created_time,deleted_actor,deleted_time,distribution_distributed_via_follow_feed,distribution_external_distribution_channels,
    distribution_feed_distribution,first_published_at,last_modified_actor,lifecycle_state,response_context_parent,response_context_root,specific_content_primary_landing_page_url,
    specific_content_share_commentary_attributes,specific_content_share_commentary_inferred_locale, LEFT (specific_content_share_commentary_text, 150)  AS   specific_content_share_commentary_text,
    specific_content_share_media_category,target_audience_targeted_entities,version_tag,visibility
    FROM
         {{ ref('ugc_post_history_raw')}}


),

ugc_post_share_content_media_raw as (

    SELECT 
        last_modified_time as lmt_2,ugc_post_id as id ,_fivetran_synced AS sync_time_3,description_attributes,description_inferred_locale,description_text,
    landing_page_title,landing_page_url,media,original_url,status,thumbnails,title_attributes,title_inferred_locale,title_text
    FROM
         {{ ref('ugc_post_share_content_media_raw')}}


),

final as (

    Select
        *

    From share_statistic_raw

    left join ugc_post_history_raw using (id)

    left join ugc_post_share_content_media_raw using(id)

),

final2 as (

SELECT 
    * 
FROM 
    final
)

Select *
FROM final2
-- Where specific_content_share_commentary_text like '%The numbers say it all! Unlock the perfect balance of data%'
