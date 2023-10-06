select day, count(1),
sum(impressions) as impressions,
sum(uniques) as uniques,
sum(clicks) as clicks, sum(views) as views,
sum(last_touch_clicks) as last_touch_clicks,
sum(last_touch_views) as last_touch_views,
sum(last_tv_touch_clicks) as last_tv_touch_clicks,
sum(last_tv_touch_views) as last_tv_touch_views,
sum(click_conversions) as click_conversions,
sum(view_conversions) as view_conversions,
sum(last_touch_clicks) as last_touch_clicks,
 sum(last_touch_views) as last_touch_views
 from sum_by_advertiser_by_day s
 left join advertisers g
    on g.advertiser_id = s.advertiser_id
 where s.advertiser_id != g.advertiser_id
 and day >= '2023-08-01' group by 1 order by 1