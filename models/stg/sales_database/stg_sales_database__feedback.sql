with source as (
       
           select * from {{ source('ingestion_fivetran_public', 'feedback') }}
       
       ),
       
       renamed as (
       
        select
            ctid_fivetran_id,
            concat(feedback_id,"_",order_id) as feedback_id,
            order_id as order_id,
            coalesce(feedback_score, 0) as feedback_score,
            cast(feedback_form_sent_date as timestamp) as feedback_form_sent_at,
            cast(feedback_answer_date as timestamp) as feedback_answer_at,
            coalesce(_fivetran_deleted, false) as is_fivetran_deleted,
            _fivetran_synced
       
           from source
       
       )
       
       select * from renamed
       qualify row_number() over (partition by feedback_id order by _fivetran_synced desc) = 1