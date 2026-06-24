-- Les commandes complétées (status=4) doivent avoir une date d'expédition
select
    order_id,
    order_status,
    shipped_date
from {{ ref('stg_localbike__orders') }}
where order_status = 4
  and shipped_date is null
