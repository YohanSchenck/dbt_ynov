with 

source as (

    select * from {{ source('public', 'brands') }}

),

renamed as (

    select
        ctid_fivetran_id,
        brand_name,
        brand_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed