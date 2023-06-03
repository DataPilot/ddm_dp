
{{
    config(
        materialized='table'
    )
}}


with li_page_posts_transf as (

    SELECT 
       click_count, comment_count, engagement, impression_count, like_count, share_count, lmt_1 as  last_modified_time, specific_content_share_media_category as content_share_media_category, specific_content_share_commentary_text as text, created_time 
        
    FROM
         {{ ref('li_page_posts_transf')}}

),

li_page_share_posts_stats_transf as (

    SELECT 
       click_count, comment_count, engagement, impression_count, like_count, share_count, last_modified_time, content_share_media_category, text , created_time
    FROM
         {{ ref('li_page_share_posts_stats_transf')}}

),

final as (

    Select
       click_count, comment_count, engagement, impression_count, like_count, share_count, last_modified_time, content_share_media_category, text, created_time 

    From li_page_posts_transf

    UNION ALL
    
    SELECT
       click_count, comment_count, engagement, impression_count, like_count, share_count, last_modified_time, content_share_media_category, text , created_time

    FROM li_page_share_posts_stats_transf 

), final2 as 

(

SELECT 
    * 
FROM 
    final
WHERE
content_share_media_category IS NOT NULL
ORDER BY
    created_time DESC

)

SELECT *
FROM final2

-- Where text like '%The numbers say it all! Unlock the perfect balance of data%'




-- SELECT text, COUNT(text) as count
-- FROM final2
-- GROUP BY text
-- HAVING COUNT(text) > 1;
