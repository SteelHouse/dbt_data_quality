{% set start_date = modules.datetime.date.today() %}

{{
    config(
        materialized='ephemeral'
    )
}}

SELECT * FROM sum_by_campaign_by_day WHERE day >= CURRENT_DATE - INTERVAL '1 day' AND day < CURRENT_DATE