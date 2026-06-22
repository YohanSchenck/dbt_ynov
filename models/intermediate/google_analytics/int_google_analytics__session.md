{% docs int_google_analytics__session %}

## Vue d'ensemble

Ce modèle intermédiaire agrège les événements bruts de Google Analytics en résumés au niveau session, fournissant des métriques sur la durée de session, les pages vues et les sources de trafic.

## Sources

- `stg_google_analytics__events_flattened` : Événements GA aplatis avec identifiants de session et métadonnées de trafic

## Granularité

Une ligne par **session** (`unique_session_id`).

## Logique métier

- **session_duration_seconds** : Calculé via `timestamp_diff(max(event_timestamp), min(event_timestamp), second)` — le temps écoulé entre le premier et le dernier événement de la session.
- **event_count** : Nombre total d'événements (`count(1)`) enregistrés pendant la session.
- **pages_viewed** : Nombre d'événements où `event_name = 'page_view'`.
- **browser_used, traffic_medium, traffic_source, traffic_name** : Récupérés via `any_value()` car ces dimensions sont constantes au sein d'une session.

{% enddocs %}
