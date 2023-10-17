select *
from {{ ref('spoof_impressions') }} a
JOIN {{ ref('spoof_cost_impressions') }} b
ON a.id == b.id

