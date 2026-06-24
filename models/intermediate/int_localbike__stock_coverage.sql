with

stocks as (
    select * from {{ ref('stg_localbike__stocks') }}
    where _fivetran_deleted = false
),

product_perf as (
    select * from {{ ref('int_localbike__product_performance') }}
),

stores as (
    select * from {{ ref('stg_localbike__stores') }}
),

stock_enriched as (

    select
        sk.store_id,
        st.store_name,
        sk.product_id,
        pp.product_name,
        pp.brand_name,
        pp.category_name,
        pp.list_price,

        sk.quantity as current_stock,
        coalesce(pp.total_units_sold, 0) as total_units_sold,

        case
            when sk.quantity = 0 then 'out_of_stock'
            when sk.quantity <= 3 then 'low_stock'
            when sk.quantity <= 10 then 'medium_stock'
            else 'well_stocked'
        end as stock_level

    from stocks sk
    inner join stores st on sk.store_id = st.store_id
    left join product_perf pp on sk.product_id = pp.product_id

)

select * from stock_enriched
