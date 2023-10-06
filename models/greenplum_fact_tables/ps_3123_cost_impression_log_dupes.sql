{% set start_date = modules.datetime.date.today() %}

{{
    config(
        materialized='ephemeral'
    )
}}

SELECT * FROM cost_impression_log  where time >= CURRENT_DATE - INTERVAL '1 day' AND time < CURRENT_DATE