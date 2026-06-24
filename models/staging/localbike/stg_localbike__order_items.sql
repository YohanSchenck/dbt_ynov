with source as (

    select * from {{ source('localbike', 'order_items') }}

),

renamed as (

    select
        -- clé technique (order_id + item_id)
        {{ dbt_utils.generate_surrogate_key(['order_id', 'item_id']) }} as order_item_id,

        -- ids
        order_id,
        item_id,
        product_id,

        -- mesures
        quantity,
        list_price,
        discount,
        round(quantity * list_price * (1 - discount), 2) as net_amount

    from source

)

select * from renamed
