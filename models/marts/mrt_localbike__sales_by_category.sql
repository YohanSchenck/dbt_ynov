with

order_details as (
    select * from {{ ref('int_localbike__order_details') }}
    where order_status = 4
),

category_store as (

    select
        store_name,
        category_name,
        brand_name,

        count(distinct order_id)    as nb_orders,
        sum(quantity)               as total_units,
        sum(line_total)             as total_revenue,
        avg(discount)               as avg_discount,
        count(distinct customer_id) as nb_distinct_customers

    from order_details
    group by store_name, category_name, brand_name

)

select * from category_store
