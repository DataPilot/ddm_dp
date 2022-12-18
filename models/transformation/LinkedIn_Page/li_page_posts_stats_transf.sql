
{{
    config(
        materialized='table'
    )
}}


with share_statistic_raw as (

    SELECT 
        *,_share_entity_urn as id
    FROM
         {{ ref('share_statistic_raw')}}

),


ugc_post_history_raw as (

    SELECT 
        *
    FROM
         {{ ref('ugc_post_history_raw')}}


),

ugc_post_share_content_media_raw as (

    SELECT 
        *, ugc_post_id AS id
    FROM
         {{ ref('ugc_post_share_content_media_raw')}}


),

final as (

    Select
        *

    From share_statistic_raw

    left join ugc_post_history_raw using (id)

    left join ugc_post_share_content_media_raw using(id)

)

SELECT 
    * 
FROM 
    final





