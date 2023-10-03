-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where this isn't true to make the test fail

SELECT * FROM {{ ref('impression_facts_vast_completes' )}} WHERE vast_complete > vast_start