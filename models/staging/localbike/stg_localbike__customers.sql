with source as (

    select * from {{ source('localbike', 'customers') }}

),

renamed as (

    select
        -- ids
        customer_id,

        -- attributs
        first_name,
        last_name,
        lower(email)            as email,
        phone,

        -- adresse
        street,
        city,
        state,
        zip_code

    from source

)

select * from renamed
