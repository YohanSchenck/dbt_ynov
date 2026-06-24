with 

source as (

    select * from {{ source('public', 'order_items') }}

),

renamed as (

    select
        ctid_fivetran_id,
        quantity,
        item_id,
        product_id,
        discount,
        list_price,
        order_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed