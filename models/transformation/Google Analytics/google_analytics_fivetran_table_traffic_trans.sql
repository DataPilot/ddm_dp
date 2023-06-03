{{
    config(
        materialized='table'
    )
}}

with google_analytics_fivetran_table_traffic_raw as (

    SELECT 
        _fivetran_id, date, profile, _fivetran_synced,  regexp_replace(
    cast(time(ts) as string), 
    r'^\d\d', 
    cast(extract(hour from time(ts)) + 24 * unix_date(date(ts)) as string)
  ) as option1
        
         avg_time_on_page, bounce_rate, entrances, exit_rate, page_title,
    page_value, pageviews, unique_pageviews, users

    CAST (Users as numeric) AS Users


    FROM 
        {{ ref('google_analytics_fivetran_table_traffic_raw')}}

  
    
)

SELECT
    *
FROM google_analytics_fivetran_table_traffic_raw

