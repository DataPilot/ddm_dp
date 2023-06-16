
{{
    config(
        materialized='table'
    )
}}


with share_statistic_raw as (

    SELECT 
       _fivetran_id as id, _fivetran_synced AS sync_time_1,_organization_entity_urn,_share_entity_urn as id1 ,click_count,comment_count,
        engagement,impression_count,like_count,share_count
       
       
        
    FROM
         {{ ref('share_statistic_raw')}}

),




share_share_statitic_raw as (

    SELECT 
        share_id as id2,share_statistic_id as id, _fivetran_synced as ft2
    FROM
         {{ ref('share_share_statitic_raw')}}


),

share_history_raw as (

    SELECT 
        id as id2, last_modified_time, _fivetran_synced as ft3, activity, agent, client_app, content_content_entities, content_description, content_landing_page_url, content_share_media_category,
    content_title,  created_actor, created_time, distribution_target_connections_only, distribution_target_visible_to_guest, edited, last_modified_actor, original_share_id,
    owner, reshared_share_id, subject, left (text,150) AS text, text_annotations
    FROM
         {{ ref('share_history_raw')}}


),

final as (

    Select
        *

    From share_statistic_raw

    left join share_share_statitic_raw using (id)

    left join share_history_raw using(id2)

) , final2 as
(
SELECT 
    * 
FROM 
    final

)

SELECT *
FROM final2

-- Where text like '%The numbers say it all! Unlock the perfect balance of data%'