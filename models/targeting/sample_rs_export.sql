{% set start_date = modules.datetime.date.today() %}

{{
    config(
        materialized='ephemeral'
    )
}}


select ip,
       FLATTEN(data_sources.cats) as cats,
       data_sources.data_source_id as data_sources,
       geo_location.lat as lat,
       geo_location.long as long,
       geo_location.accuracy_radius as radius
from json.`s3://sh-dw-external-tables-dev/ip_data/2023/12/14/879983/geo_version=1640995200/`
