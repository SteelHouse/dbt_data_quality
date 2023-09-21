-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where this isn't true to make the test fail

SELECT * FROM {{ ref('event_log_vast_completes_philtest' )}} WHERE vast_completes > vast_starts