{% set start_date = modules.datetime.date.today() %}

{{
    config(
        materialized='ephemeral'
    )
}}


SELECT get_json_object(raw_data, '$.ip') as ip FROM data_archive_prod.tpa_export_json_raw ORDER by rand() LIMIT 100000