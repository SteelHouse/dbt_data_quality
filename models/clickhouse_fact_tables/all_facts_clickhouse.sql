{% set start_date = modules.datetime.date.today() %}

{{
    config(
        materialized='ephemeral'
    )
}}


SELECT advertiser_id,
campaign_id,
vast_start,
vast_complete
from {{source('clickhouse', 'stg_all_facts_mn')}} where hour = {{start_date}}

