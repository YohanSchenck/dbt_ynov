with

order_details as (
    select * from {{ ref('int_localbike__order_details') }}
),

order_totals as (

    select
        order_id,
        customer_id,
        order_status,
        order_date,
        store_id,
        store_name,
        sum(line_total) as order_total

    from order_details
    group by order_id, customer_id, order_status, order_date, store_id, store_name

),

customer_agg as (

    select
        customer_id,

        count(distinct order_id) as total_orders,
        count(distinct case when order_status = 4 then order_id end) as completed_orders,
        count(distinct case when order_status = 3 then order_id end) as rejected_orders,

        sum(case when order_status = 4 then order_total else 0 end) as total_revenue,
        avg(case when order_status = 4 then order_total end) as avg_order_value,

        min(order_date) as first_order_date,
        max(order_date) as last_order_date,

        count(distinct store_id) as distinct_stores_visited

    from order_totals
    group by customer_id

)

select * from customer_agg
