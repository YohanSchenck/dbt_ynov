-- Ensures no delivered order has a delivery date after the estimated delivery date
select
    order_id,
    delivered_at,
    estimated_delivery_on
from {{ ref('stg_sales_database__order') }}
where
    delivered_at is not null
    and estimated_delivery_on is not null
    and cast(delivered_at as date) > estimated_delivery_on
