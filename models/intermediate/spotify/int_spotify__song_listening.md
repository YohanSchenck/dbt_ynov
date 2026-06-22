{% docs int_spotify__song_listening %}

## Vue d'ensemble

Ce modèle intermédiaire joint les données d'écoute avec les métadonnées des chansons, fournissant une vue dénormalisée de l'activité d'écoute enrichie avec les détails des chansons. Seuls les enregistrements d'écoute des 2 dernières années sont inclus.

## Sources

- `stg_spotify__listening_data` : Enregistrements d'écoute bruts (song_id, listen_date, minutes_listened)
- `stg_spotify__songs` : Métadonnées des chansons (title, artist, album, genre)

## Granularité

Une ligne par **événement d'écoute** (`song_id` + `listen_date`).

## Logique métier

- La jointure est un left join des données d'écoute vers les chansons sur `song_id`, garantissant que tous les enregistrements d'écoute sont conservés même si les métadonnées de la chanson sont manquantes.
- Les enregistrements sont filtrés pour n'inclure que les dates d'écoute des 2 dernières années (`DATE_SUB(CURRENT_DATE(), INTERVAL 2 YEAR)`).

{% enddocs %}
