with source as (

    select * from {{ source('localbike', 'staffs') }}

),

renamed as (

    select
        -- ids
        staff_id,
        store_id,
        manager_id,

        -- attributs
        first_name,
        last_name,
        lower(email)            as email,
        phone,
        cast(active as boolean) as is_active

    from source

)

select * from renamed
