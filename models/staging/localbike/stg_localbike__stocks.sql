with 

source as (

    select * from {{ source('public', 'stocks') }}

),

renamed as (

    select
        ctid_fivetran_id,
        store_id,
        quantity,
        product_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed