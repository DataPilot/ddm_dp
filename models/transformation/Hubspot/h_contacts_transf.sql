
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

SELECT *, id as id2
FROM h_Contacts_raw
