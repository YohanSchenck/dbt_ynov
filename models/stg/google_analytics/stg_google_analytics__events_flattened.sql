with 

source as (

    select * from {{ source('tp4_Exo2_EU', 'events_flattened') }}

),

renamed as (

    select
        parse_date('%Y%m%d', event_date) as event_date,
        event_name,
        timestamp_micros(event_timestamp) as event_timestamp,
        user_pseudo_id,
        timestamp_micros(user_first_touch_timestamp) as user_first_touch_at,
        ga_session_id,
        concat(user_pseudo_id, '-', cast(ga_session_id as string)) as unique_session_id,
        page_title,
        page_location,
        browser,
        medium,
        source,
        traffic_source_name

    from source

)

select * from renamed