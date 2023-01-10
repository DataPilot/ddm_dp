
{{
    config(
        materialized='table'
    )
}}



with h_ft_email_campaign_raw as (

    SELECT 
       id, _fivetran_synced as ft1, app_id,app_name, content_id, name, num_included,num_queued,sub_type,
        subject, type as campaign_type

    FROM 
        {{ ref('h_ft_email_campaign_raw')}}

    

    
    
),


h_ft_email_event_raw as (

    SELECT 
        id as ft_id, _fivetran_synced as ft2, app_id as app_id2, caused_by_created, caused_by_id, created, email_campaign_id as id,
        filtered_event, obsoleted_by_created, obsoleted_by_id, portal_id, recipient, sent_by_created, sent_by_id, type as email_type
    FROM
         {{ ref('h_ft_email_event_raw')}}

    Where app_id = 113


),



final as (

    Select
        *

    From h_ft_email_campaign_raw

    left join h_ft_email_event_raw using (id)


)

SELECT 
    * 
FROM 
    final
