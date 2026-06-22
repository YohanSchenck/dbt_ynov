with source as (
    select * from {{ source('Spotify', 'songs') }}
)

select
    song_id,
    UPPER(title)  as title,
    UPPER(artist) as artist,
    album,
    release_year,
    COALESCE(genre, 'Unknown') as genre
from source