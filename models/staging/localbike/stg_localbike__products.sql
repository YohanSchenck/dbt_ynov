with 

source as (

    select * from {{ source('public', 'products') }}

),

renamed as (

    select
        ctid_fivetran_id,
        category_id,
        product_id,
        model_year,
        list_price,
        product_name,
        brand_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed