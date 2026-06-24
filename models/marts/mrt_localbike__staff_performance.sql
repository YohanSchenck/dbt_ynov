with

order_details as (
    select * from {{ ref('int_localbike__order_details') }}
    where order_status = 4
),

staff_agg as (

    select
        staff_id,
        staff_full_name,
        store_id,
        store_name,

        count(distinct order_id)    as nb_orders,
        count(distinct customer_id) as nb_customers,
        sum(quantity)               as total_units,
        sum(line_total)             as total_revenue,
        round(sum(line_total) / nullif(count(distinct order_id), 0), 2) as avg_order_value,

        min(order_date) as first_sale_date,
        max(order_date) as last_sale_date

    from order_details
    group by staff_id, staff_full_name, store_id, store_name

)

select * from staff_agg
