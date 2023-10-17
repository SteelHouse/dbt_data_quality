{% set start_date = modules.datetime.date.today() %}

{{
    config(
        materialized='ephemeral'
    )
}}

SELECT * FROM sum_by_segment_by_day WHERE day = '2022-08-19'