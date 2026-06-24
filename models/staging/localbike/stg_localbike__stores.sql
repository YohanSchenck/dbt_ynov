with source as (

    select * from {{ source('localbike', 'stores') }}

),

renamed as (

    select
        -- ids
        store_id,

        -- attributs
        store_name,
        lower(email)    as email,
        phone,

        -- adresse
        street,
        city,
        state,
        zip_code

    from source

)

select * from renamed
