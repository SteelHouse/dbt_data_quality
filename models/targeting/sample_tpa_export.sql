{% set start_date = modules.datetime.date.today() %}

{{
    config(
        materialized='ephemeral'
    )
}}


SELECT ip FROM data_archive_prod.tpa_export_ion