with 

source as (

    select * from {{ source('public', 'orders') }}

),

renamed as (

    select
        ctid_fivetran_id,
        store_id,
        order_status,
        order_date,
        required_date,
        shipped_date,
        staff_id,
        customer_id,
        order_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed