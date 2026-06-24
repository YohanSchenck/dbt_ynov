with

order_details as (
    select * from {{ ref('int_localbike__order_details') }}
),

completed as (
    select * from order_details where order_status = 4
),

all_orders as (
    select
        store_id,
        store_name,
        count(distinct order_id) as total_orders,
        count(distinct case when order_status = 4 then order_id end) as completed_orders,
        count(distinct case when order_status = 3 then order_id end) as rejected_orders,
        count(distinct case when order_status in (1, 2) then order_id end) as pending_processing_orders
    from order_details
    group by store_id, store_name
),

revenue as (
    select
        store_id,
        sum(line_total) as total_revenue,
        count(distinct customer_id) as nb_customers,
        count(distinct product_id) as nb_products_sold,
        sum(quantity) as total_units_sold,
        round(sum(line_total) / nullif(count(distinct order_id), 0), 2) as avg_order_value
    from completed
    group by store_id
),

staff_count as (
    select
        store_id,
        count(distinct staff_id) as nb_staff
    from order_details
    group by store_id
)

select
    ao.store_id,
    ao.store_name,
    ao.total_orders,
    ao.completed_orders,
    ao.rejected_orders,
    ao.pending_processing_orders,
    round(ao.completed_orders * 100.0 / nullif(ao.total_orders, 0), 1) as completion_rate_pct,
    r.total_revenue,
    r.nb_customers,
    r.nb_products_sold,
    r.total_units_sold,
    r.avg_order_value,
    sc.nb_staff,
    round(r.total_revenue / nullif(sc.nb_staff, 0), 2) as revenue_per_staff

from all_orders ao
left join revenue r on ao.store_id = r.store_id
left join staff_count sc on ao.store_id = sc.store_id
