{% set start_date = modules.datetime.date.today() %}

{{
    config(
        materialized='ephemeral'
    )
}}

SELECT * FROM summarydata.impression_facts WHERE hour >= CURRENT_DATE - INTERVAL '1 day' AND hour < CURRENT_DATE