with source as (
       
           select * from {{ source('ingestion_fivetran_public', 'order_item') }}
       
       ),
       
       renamed as (
       
           select
            concat(order_id, '-', product_id) as order_item_id,
            ctid_fivetran_id,
            order_id,
            product_id,
            seller_id,
            coalesce(cast(quantity as int), 0) as quantity,
            coalesce(cast(price as float64), 0.0) as price,
            coalesce(cast(shipping_cost as float64), 0.0) as shipping_cost,
            cast(pickup_limit_date as timestamp) as pickup_limit_at,
            _fivetran_deleted,
            _fivetran_synced
       
           from source
       
       )
       
       select * from renamed
       qualify row_number() over (partition by order_item_id order by _fivetran_synced desc) = 1