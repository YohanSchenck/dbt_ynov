with source as (
       
           select * from {{ source('ingestion_fivetran_public', 'payment') }}
       
       ),
       
       renamed as (
       
           select
            concat(order_id, '-', cast(payment_sequential as string)) as payment_id,
            ctid_fivetran_id,
            order_id,
            payment_sequential,
            payment_type,
            payment_installments,
            coalesce(payment_value,0.0) as payment_value,
            _fivetran_deleted,
            _fivetran_synced
       
           from source
       
       )
       
       select * from renamed
       qualify row_number() over (partition by payment_id order by _fivetran_synced desc) = 1