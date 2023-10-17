
-- Use the `ref` function to select from other models

select *
from {{ ref('spoof_impressions') }}
where id = 1
