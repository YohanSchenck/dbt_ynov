-- Ensures no order item has a negative total amount (price * quantity + shipping_cost)
select
    order_item_id,
    quantity,
    price,
    shipping_cost,
    (price * quantity + shipping_cost) as total_amount
from {{ ref('stg_sales_database__order_item') }}
where (price * quantity + shipping_cost) < 0
