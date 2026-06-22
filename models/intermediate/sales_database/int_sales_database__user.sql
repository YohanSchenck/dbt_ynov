with users as (
    select * from {{ ref('stg_sales_database__user') }}
),

-- Utilisation du modèle intermédiaire orders créé juste au-dessus pour obtenir les métriques d'achat
user_orders_aggregated as (
    select
        user_id,
        sum(total_order_amount) as total_amount_order,
        count(distinct order_id) as total_orders
    from {{ ref('int_sales_database__order') }}
    group by user_id
)

select
    u.user_id,
    u.customer_city,
    coalesce(uo.total_amount_order, 0.0) as total_amount_order,
    coalesce(uo.total_orders, 0) as total_orders
from users u
left join user_orders_aggregated uo 
    on uo.user_id = u.user_id