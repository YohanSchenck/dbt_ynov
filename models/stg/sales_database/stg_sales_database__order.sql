with source as (
       
           select * from {{ source('ingestion_fivetran_public', 'order') }}
       
       ),
       
       renamed as (
       
           select
            ctid_fivetran_id,
            order_id,
            user_name as user_id,
            order_status,
            cast(order_date as timestamp) as ordered_at,
            cast(order_approved_date as timestamp) as order_approved_at,
            cast(pickup_date as timestamp) as picked_up_at,
            cast(delivered_date as timestamp) as delivered_at,
            cast(estimated_time_delivery as date) as estimated_delivery_on,
            _fivetran_deleted,
            _fivetran_synced
       
           from source
       
       )
       
       select * from renamed
       qualify row_number() over (partition by order_id order by _fivetran_synced desc) = 1