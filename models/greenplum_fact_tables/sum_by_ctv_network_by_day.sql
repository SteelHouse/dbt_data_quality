{% set start_date = modules.datetime.date.today() %}

{{
    config(
        materialized='ephemeral'
    )
}}

SELECT * FROM summarydata.sum_by_ctv_network_by_day WHERE day >= CURRENT_DATE - INTERVAL '1 day' AND day < CURRENT_DATE