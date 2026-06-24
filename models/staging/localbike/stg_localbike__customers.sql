with 

source as (

    select * from {{ source('public', 'customers') }}

),

renamed as (

    select
        ctid_fivetran_id,
        phone,
        city,
        street,
        last_name,
        state,
        customer_id,
        first_name,
        email,
        zip_code,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed