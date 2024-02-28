{% set start_date = modules.datetime.date.today() %}

{{
    config(
        materialized='ephemeral'
    )
}}


select ip,
       FLATTEN(data_sources.cats) as cats,
       data_sources.data_source_id as data_sources,
       geo_location,
       geo_location.lat as lat,
       geo_location.long as long,
       geo_location.accuracy_radius as radius
from json.`s3://sh-dw-external-tables-prod/ip_data/2024/02/27/501925/geo_version=1640995200/part-00000-db4939ce-76bf-466b-a27d-33c190ec2675.c000.json`
