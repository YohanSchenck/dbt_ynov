with 

source as (

    select * from {{ source('public', 'categories') }}

),

renamed as (

    select
        ctid_fivetran_id,
        category_name,
        category_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed