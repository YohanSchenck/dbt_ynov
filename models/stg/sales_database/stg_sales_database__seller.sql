with source as (
       
           select * from {{ source('ingestion_fivetran_public', 'seller') }}
       
       ),
       
       renamed as (
       
           select
               ctid_fivetran_id,
               seller_zip_code,
               seller_city,
               seller_id,
               seller_state,
               _fivetran_deleted,
               _fivetran_synced
       
           from source
       
       )
       
       select * from renamed
       qualify row_number() over (partition by seller_id order by _fivetran_synced desc) = 1