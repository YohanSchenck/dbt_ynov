with

customers as (
    select * from {{ ref('stg_localbike__customers') }}
),

customer_orders as (
    select * from {{ ref('int_localbike__customer_orders') }}
),

segmented as (

    select
        c.customer_id,
        c.first_name,
        c.last_name,
        c.city,
        c.state,

        coalesce(co.total_orders, 0)      as total_orders,
        coalesce(co.completed_orders, 0)   as completed_orders,
        coalesce(co.rejected_orders, 0)    as rejected_orders,
        coalesce(co.total_revenue, 0)      as total_revenue,
        co.avg_order_value,
        co.first_order_date,
        co.last_order_date,

        case
            when co.total_orders is null then 'no_order'
            when co.completed_orders = 0 then 'no_completed_order'
            when co.total_revenue >= 10000 then 'vip'
            when co.total_revenue >= 3000 then 'regular'
            else 'occasional'
        end as customer_segment

    from customers c
    left join customer_orders co on c.customer_id = co.customer_id

)

select * from segmented
