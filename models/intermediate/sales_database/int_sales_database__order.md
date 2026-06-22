{% docs int_sales_database__order %}

## Vue d'ensemble

Ce modèle intermédiaire enrichit les commandes brutes avec les métriques agrégées des articles, les données géographiques des utilisateurs et les scores moyens de satisfaction.

## Sources

- `stg_sales_database__order` : Informations de base sur les commandes (statut, horodatages)
- `stg_sales_database__user` : Données géographiques de l'utilisateur (ville, état)
- `stg_sales_database__order_item` : Articles de commande agrégés pour calculer les montants totaux, le nombre d'articles et le nombre de produits distincts
- `stg_sales_database__feedback` : Retours clients agrégés pour calculer les scores moyens par commande

## Granularité

Une ligne par **commande** (`order_id`).

## Logique métier

- **total_order_amount** : Somme de `price + shipping_cost` pour tous les articles de la commande.
- **total_items** : Somme des `quantity` de tous les articles de la commande.
- **total_distinct_items** : Nombre de valeurs distinctes de `product_id` dans la commande.
- **average_feedback_score** : Moyenne de toutes les valeurs de `feedback_score` associées à la commande. Défaut à 0.0 lorsqu'aucun feedback n'existe.

{% enddocs %}
