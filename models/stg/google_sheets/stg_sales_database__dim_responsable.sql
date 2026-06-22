with 

source as (

    select * from {{ source('tp4', 'dim_responsable') }}

),

renamed as (

    select
        _row,
        _fivetran_synced,
        state,
        account_manager

    from source

)

select * from renamed
qualify row_number() over (partition by state order by _fivetran_synced desc) = 1