{% docs int_sales_database__user %}

## Vue d'ensemble

Ce modèle intermédiaire enrichit les utilisateurs avec les métriques agrégées de commandes, fournissant un résumé au niveau client du comportement d'achat.

## Sources

- `stg_sales_database__user` : Informations de base sur l'utilisateur (ville, état)
- `int_sales_database__order` : Commandes enrichies utilisées pour calculer le total des dépenses et le nombre de commandes par utilisateur

## Granularité

Une ligne par **utilisateur** (`user_id`).

## Logique métier

- **total_amount_order** : Somme de `total_order_amount` du modèle de commandes enrichies pour chaque utilisateur. Défaut à 0.0 lorsqu'aucune commande n'existe.
- **total_orders** : Nombre de valeurs distinctes de `order_id` pour chaque utilisateur. Défaut à 0 lorsqu'aucune commande n'existe.

{% enddocs %}
