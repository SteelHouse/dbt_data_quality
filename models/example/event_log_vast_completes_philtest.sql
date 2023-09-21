{% set start_date = modules.datetime.date.today() %}

{{
    config(
        materialized='ephemeral'
    )
}}
WITH base as (
select elf.*, c.campaign_group_id
	, timetz(elf.time, a.time_zone) time_local
	from logdata.event_log elf
	join campaigns c
		on elf.campaign_id = c.campaign_id
	join advertisers a
		on elf.advertiser_id = a.advertiser_id
		WHERE TIME >= '2023-09-08'
		and time < '2023-09-09')
	--where time >= '{{ start_date }}'
	--and time < CURRENT_DATE)
,agg as (
SELECT advertiser_id,
       campaign_id,
       ad_served_id,
       SUM(CASE WHEN event_type_raw = 'vast_start' THEN 1 END) as vast_starts,
       SUM(CASE WHEN event_type_raw = 'vast_complete' THEN 1 END) as vast_completes
FROM base
GROUP by 1,2,3)
SELECT * FROM agg

