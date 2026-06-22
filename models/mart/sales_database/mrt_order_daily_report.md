{% docs mrt_order_daily_report %}

## Vue d'ensemble

Ce modèle mart fournit un rapport quotidien résumé des commandes, regroupé par date, responsable de compte et état du client. Il sert de table de reporting principale pour les parties prenantes métier afin de suivre l'activité et la performance quotidienne des commandes.

## Sources

- `int_sales_database__order` : Commandes enrichies avec montants, nombres d'articles et scores de satisfaction
- `stg_sales_database__dim_responsable` : Table de correspondance entre les états et les responsables de compte

## Granularité

Une ligne par combinaison **date** x **account_manager** x **order_state**.

## Logique métier

- **account_manager** : Jointure depuis la table de référence `dim_responsable` sur `user_state = state`. Défaut à `'No Manager Assigned'` lorsqu'aucune correspondance n'existe.
- **total_orders** : Nombre de valeurs distinctes de `order_id` au sein de chaque groupe.
- **average_items_per_order** : `AVG(total_items)` arrondi à 2 décimales.
- **average_feedback_score** : `AVG(average_feedback_score)` arrondi à 2 décimales.
- **average_amount_spent_per_order** : `AVG(total_order_amount)` arrondi à 2 décimales.

{% enddocs %}
