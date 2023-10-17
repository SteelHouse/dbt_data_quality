{{
    config(
        materialized='ephemeral'
    )
}}

select *
from {{ ref('spoof_impressions') }}
where id = 1