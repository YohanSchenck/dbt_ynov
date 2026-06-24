-- Le revenu total par client dans la segmentation doit correspondre au revenu
-- calculé depuis les détails de commandes (tolérance d'arrondi de 1 centime)
with from_segmentation as (
    select customer_id, total_revenue
    from {{ ref('mrt_localbike__customer_segmentation') }}
    where total_revenue > 0
),

from_orders as (
    select
        customer_id,
        round(sum(line_total), 2) as total_revenue
    from {{ ref('int_localbike__order_details') }}
    where order_status = 4
    group by customer_id
)

select
    s.customer_id,
    s.total_revenue  as segmentation_revenue,
    o.total_revenue  as order_details_revenue,
    abs(s.total_revenue - o.total_revenue) as diff
from from_segmentation s
inner join from_orders o on s.customer_id = o.customer_id
where abs(s.total_revenue - o.total_revenue) > 0.01
