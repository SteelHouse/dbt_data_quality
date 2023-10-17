with has_tpa2 as (
        SELECT DISTINCT campaign_id, audience_id, effective_start_time, effective_end_time
        FROM (
            SELECT *,
            ors::json ->> 'data_source_id' as data_source_id,
            ors::json ->  'cats' as cats
            FROM (
                SELECT campaign_id, audience_id, effective_start_time, effective_end_time, expression,
                json_array_elements((json_array_elements(expression::json -> 'interest' -> 'include')) -> 'or') AS ors
                FROM (
                    SELECT campaign_id, audience_id,
                    ROW_NUMBER() OVER(PARTITION BY campaign_id ORDER BY curr, create_time) AS seq,
                    LAG(create_time::timestamp + INTERVAL '1 second') OVER(PARTITION BY campaign_id ORDER BY curr, create_time) AS effective_start_time,
                    create_time AS effective_end_time,
                    expression
                    FROM (
                        SELECT aus.campaign_id, aus.audience_id, aus.segment_id, aus.expression, 1 AS curr, NULL AS version, NULL AS create_time
                        FROM audience.audience_segments aus
                        JOIN public.campaigns c ON c.campaign_id = aus.campaign_id
                        WHERE aus.expression_type_id = 2
                        AND c.channel_id = 8
                        AND c.objective_id = 1

                        UNION ALL

                        SELECT aus.campaign_id, aus.audience_id, aus.segment_id, aus.expression, 0 AS curr, aus.version, aus.create_time
                        FROM archives.audience_segment_archives aus
                        JOIN public.campaigns c ON c.campaign_id = aus.campaign_id
                        WHERE aus.expression_type_id = 2
                        AND c.channel_id = 8
                        AND c.objective_id = 1
                        --and c.campaign_id = 188346
                    ) audience_segments_combined
                    --where campaign_id = 188346
                ) audience_segments_by_time
            ) x
        )y
        WHERE data_source_id::int = 11)
select campaign_id, effective_start_time, count(1) from has_tpa2 group by 1,2 HAVING COUNT(1) > 1