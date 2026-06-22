with source as (
       
           select * from {{ source('ingestion_fivetran_public', 'product') }}
       
       ),
       
       renamed as (
       
           select
                ctid_fivetran_id,
                product_id,
                coalesce(product_name_lenght, 0) as product_name_length,
                coalesce(product_description_lenght, 0) as product_description_length,
                coalesce(product_photos_qty, 0) as product_photos_quantity,
                coalesce(product_weight_g, 0) as product_weight_grams,
                coalesce(product_length_cm, 0) as product_length_cm,
                coalesce(product_height_cm, 0) as product_height_cm,
                coalesce(product_width_cm, 0) as product_width_cm,
               _fivetran_deleted,
               _fivetran_synced
       
           from source
       
       )
       
       select * from renamed
       qualify row_number() over (partition by product_id order by _fivetran_synced desc) = 1