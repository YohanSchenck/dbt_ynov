with source as (

    select * from {{ source('localbike', 'orders') }}

),

renamed as (

    select
        -- ids
        order_id,
        customer_id,
        store_id,
        staff_id,

        -- statut
        order_status,

        -- dates
        cast(order_date as date)    as order_date,
        cast(required_date as date) as required_date,
        cast(shipped_date as date)  as shipped_date

    from source

)

select * from renamed
