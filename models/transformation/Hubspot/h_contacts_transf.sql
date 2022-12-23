
{{
    config(
        materialized='table'
    )
}}

with h_Contacts_raw as (

    SELECT 
        *

    FROM 
        {{ ref('h_Contacts_raw')}}

    

    
    
)

SELECT *
FROM h_Contacts_raw
