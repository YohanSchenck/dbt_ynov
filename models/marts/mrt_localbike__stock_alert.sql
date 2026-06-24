with

stock_coverage as (
    select * from {{ ref('int_localbike__stock_coverage') }}
),

alerts as (

    select
        store_id,
        store_name,
        product_id,
        product_name,
        brand_name,
        category_name,
        list_price,
        current_stock,
        total_units_sold,
        stock_level,

        case
            when current_stock = 0 and total_units_sold > 0
                then 'restock_urgent'
            when current_stock between 1 and 3 and total_units_sold > 5
                then 'restock_soon'
            when current_stock > 15 and total_units_sold = 0
                then 'overstock_no_sales'
            else 'ok'
        end as alert_type

    from stock_coverage

)

select * from alerts
where alert_type != 'ok'
