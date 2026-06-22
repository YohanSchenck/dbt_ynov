with orders as (
    select * from {{ ref('stg_sales_database__order') }}
),

users as (
    select * from {{ ref('stg_sales_database__user') }}
),

-- Agrégation des items par commande (Calcul du montant, total items et items distincts)
order_items_aggregated as (
    select
        order_id,
        sum(price + shipping_cost) as total_order_amount,
        sum(quantity) as total_items,
        count(distinct product_id) as total_distinct_items
    from {{ ref('stg_sales_database__order_item') }}
    group by order_id
),

-- Agrégation des scores de feedback par commande (Moyenne)
feedbacks_aggregated as (
    select
        order_id,
        avg(feedback_score) as average_feedback_score
    from {{ ref('stg_sales_database__feedback') }}
    group by order_id
)

select
    o.order_id,
    o.user_id, -- D'après votre staging, user_name sert d'identifiant utilisateur
    o.order_status,
    o.ordered_at as order_created_at,
    o.order_approved_at,
    u.customer_city as user_city,
    u.customer_state as user_state,
    coalesce(f.average_feedback_score, 0.0) as average_feedback_score,
    coalesce(oi.total_order_amount, 0.0) as total_order_amount,
    coalesce(oi.total_items, 0) as total_items,
    coalesce(oi.total_distinct_items, 0) as total_distinct_items
from orders o
left join users u 
    on o.user_id = u.user_id
left join order_items_aggregated oi 
    on o.order_id = oi.order_id
left join feedbacks_aggregated f 
    on o.order_id = f.order_id