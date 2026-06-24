-- Aucune ligne de commande ne doit avoir un montant net négatif ou nul
select
    order_id,
    item_id,
    line_total
from {{ ref('int_localbike__order_details') }}
where line_total <= 0
