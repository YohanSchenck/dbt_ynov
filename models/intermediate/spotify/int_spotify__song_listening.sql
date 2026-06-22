with songs as (
    select * from {{ ref('stg_spotify__songs') }}
),

listening as (
    select * from {{ ref('stg_spotify__listening_data') }}
),

joined as (
    select
        l.song_id,
        l.listen_date,
        l.minutes_listened,
        s.title,
        s.artist,
        s.album,
        s.genre
    from listening l
    left join songs s
        on l.song_id = s.song_id
    where l.listen_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 2 YEAR)
)

select * from joined