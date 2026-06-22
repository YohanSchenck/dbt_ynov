with events as (
    select * from {{ ref('stg_google_analytics__events_flattened') }}
)

select
    unique_session_id,
    user_pseudo_id,
    min(event_timestamp) as session_start_time,
    max(event_timestamp) as session_end_time,
    
    -- Calcul de la durée de la session
    timestamp_diff(max(event_timestamp), min(event_timestamp), second) as session_duration_seconds,
    
    -- Récupération des dimensions de session
    any_value(browser) as browser_used,
    any_value(medium) as traffic_medium,
    any_value(source) as traffic_source,
    any_value(traffic_source_name) as traffic_name,
    
    -- Agrégations quantitatives
    count(1) as event_count,
    countif(event_name = 'page_view') as pages_viewed
from events
group by 
    unique_session_id, 
    user_pseudo_id