{{
    config(
        materialized='table'
    )
}}

SELECT
    last_modified_time as lmt_2,ugc_post_id,_fivetran_synced AS sync_time_3,description_attributes,description_inferred_locale,description_text,
    landing_page_title,landing_page_url,media,original_url,status,thumbnails,title_attributes,title_inferred_locale,title_text
FROM {{ source('bq_ddm_LI_p', 'ugc_post_share_content_media') }} 



