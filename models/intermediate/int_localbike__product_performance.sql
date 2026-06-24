with

order_details as (
    select * from {{ ref('int_localbike__order_details') }}
    where order_status = 4
),

product_agg as (

    select
        product_id,
        product_name,
        brand_name,
        category_name,
        model_year,
        list_price,

        count(distinct order_id) as nb_orders,
        sum(quantity)             as total_units_sold,
        sum(line_total)           as total_revenue,
        avg(discount)             as avg_discount_applied

    from order_details
    group by
        product_id, product_name, brand_name, category_name,
        model_year, list_price

)

select * from product_agg
