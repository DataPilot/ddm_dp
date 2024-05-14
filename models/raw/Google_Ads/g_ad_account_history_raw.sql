{{ config(materialized="table") }}

select *
from {{ source("bq_ddm_G_ad", "account_history") }}
