with source as (

    select * from {{ source('localbike', 'products') }}

),

renamed as (

    select
        -- ids
        product_id,
        brand_id,
        category_id,

        -- attributs
        product_name,
        model_year,
        list_price

    from source

)

select * from renamed
