{{ config(materialized='table') }}

with base as (
    select * from {{ ref('int_spotify__song_listening') }}
)

select
    artist,
    SUM(minutes_listened) as total_minutes_listened
from base
group by artist
order by total_minutes_listened desc
limit 20