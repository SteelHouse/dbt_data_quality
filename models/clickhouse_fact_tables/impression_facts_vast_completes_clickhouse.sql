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
from {{source('clickhouse', 'impression_facts')}} where hour >= CURRENT_DATE - INTERVAL '1 day' AND hour < CURRENT_DATE

