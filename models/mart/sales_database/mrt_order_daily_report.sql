with orders_enriched as (
    select * from {{ ref('int_sales_database__order') }}
),

manager_mapping as (
    select * from {{ ref('stg_sales_database__dim_responsable') }}
)

select
    -- 1. Les Dimensions demandées
    cast(order_created_at as date) as order_date,
    coalesce(m.account_manager, 'No Manager Assigned') as account_manager,
    o.user_state as order_state,

    -- 2. Les Métriques calculées par jour / manager / état
    count(distinct o.order_id) as total_orders,
    round(avg(o.total_items), 2) as average_items_per_order,
    round(avg(o.average_feedback_score), 2) as average_feedback_score,
    round(avg(o.total_order_amount), 2) as average_amount_spent_per_order

from orders_enriched o
-- Jointure sur le code de l'état (ex: SP, RJ, etc.) pour récupérer le manager responsable
left join manager_mapping m 
    on o.user_state = m.state
group by 
    1, 2, 3