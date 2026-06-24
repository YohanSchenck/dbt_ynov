with 

source as (

    select * from {{ source('public', 'stores') }}

),

renamed as (

    select
        ctid_fivetran_id,
        store_id,
        phone,
        city,
        street,
        store_name,
        state,
        email,
        zip_code,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed