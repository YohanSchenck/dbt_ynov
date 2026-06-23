-- Vérifie qu'aucune commande n'a une date d'approbation antérieure à la date de commande
select
    order_id,
    ordered_at,
    order_approved_at
from {{ ref('stg_sales_database__order') }}
where
    order_approved_at is not null
    and ordered_at is not null
    and order_approved_at < ordered_at
