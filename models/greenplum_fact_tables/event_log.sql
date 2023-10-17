{% set start_date = modules.datetime.date.today() %}

{{
    config(
        materialized='ephemeral'
    )
}}

SELECT * FROM logdata.event_log WHERE time >= CURRENT_DATE - INTERVAL '1 day' AND time < CURRENT_DATE