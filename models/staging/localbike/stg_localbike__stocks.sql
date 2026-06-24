with source as (

    select * from {{ source('localbike', 'stocks') }}

),

renamed as (

    select
        -- clé technique (store_id + product_id)
        {{ dbt_utils.generate_surrogate_key(['store_id', 'product_id']) }} as stock_id,

        -- ids
        store_id,
        product_id,

        -- mesures
        quantity

    from source

)

select * from renamed
