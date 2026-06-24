with source as (

    select * from {{ source('localbike', 'brands') }}

),

renamed as (

    select
        brand_id,
        brand_name

    from source

)

select * from renamed
