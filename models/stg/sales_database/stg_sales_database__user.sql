with source as (
       
           select * from {{ source('ingestion_fivetran_public', 'user') }}
       
       ),
       
       renamed as (
       
           select
               ctid_fivetran_id,
               customer_zip_code,
               customer_state,
               user_name as user_id,
               row_num,
               customer_city,
               _fivetran_deleted,
               _fivetran_synced
       
           from source
       
       )
       
       select * from renamed
       qualify row_number() over (partition by user_id order by _fivetran_synced desc) = 1