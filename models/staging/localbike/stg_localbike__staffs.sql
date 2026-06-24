with 

source as (

    select * from {{ source('public', 'staffs') }}

),

renamed as (

    select
        ctid_fivetran_id,
        store_id,
        phone,
        manager_id,
        staff_id,
        last_name,
        active,
        first_name,
        email,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed