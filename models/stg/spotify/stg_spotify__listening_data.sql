with source as (
    select * from {{ source('Spotify', 'listening_data') }}
)

select
    song_id,
    CAST(listen_date as DATE)           as listen_date,
    COALESCE(minutes_listened, 0)       as minutes_listened
from source