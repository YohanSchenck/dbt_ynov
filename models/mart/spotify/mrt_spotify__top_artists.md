{% docs mrt_spotify__top_artists %}

## Vue d'ensemble

Ce modèle mart classe les 20 meilleurs artistes par temps d'écoute total. Il fournit un classement des artistes les plus écoutés basé sur les données d'écoute Spotify agrégées des 2 dernières années.

## Sources

- `int_spotify__song_listening` : Événements d'écoute joints avec les métadonnées des chansons

## Granularité

Une ligne par **artiste**, limité aux 20 premiers par nombre total de minutes d'écoute.

## Logique métier

- **total_minutes_listened** : `SUM(minutes_listened)` regroupé par artiste.
- Les résultats sont triés par `total_minutes_listened DESC` et limités aux 20 premiers artistes.
- Matérialisé en table pour un accès direct en requête.

{% enddocs %}
