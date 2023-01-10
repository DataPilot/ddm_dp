
{{
    config(
        materialized='table'
    )
}}

with google_analytics_fivetran_table_ad_adwords_keyword_raw as (

    SELECT 
        _fivetran_id,date ,profile,_fivetran_synced,CAST (ad_clicks AS NUMERIC) as ad_clicks, ad_cost, bounce_rate, cpc, keyword, 
        pageviews_per_session, sessions, users,ctr, impressions, time_on_page

    FROM 
        {{ ref('google_analytics_fivetran_table_ad_adwords_keyword_raw')}}

    

    
    
)

SELECT *
FROM google_analytics_fivetran_table_ad_adwords_keyword_raw
