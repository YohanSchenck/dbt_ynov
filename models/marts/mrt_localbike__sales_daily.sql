with

order_details as (
    select * from {{ ref('int_localbike__order_details') }}
    where order_status = 4
),

daily as (

    select
        order_date,
        store_id,
        store_name,

        count(distinct order_id)    as nb_orders,
        count(distinct customer_id) as nb_customers,
        sum(quantity)               as total_units,
        sum(line_total)             as total_revenue,
        round(sum(line_total) / nullif(count(distinct order_id), 0), 2) as avg_order_value

    from order_details
    group by order_date, store_id, store_name

)

select * from daily
