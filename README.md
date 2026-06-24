# Local Bike — Projet Final (dbt)

Modélisation des données de **Local Bike** pour alimenter le premier tableau de bord
de l'entreprise et soutenir l'équipe des opérations (optimisation des ventes, revenus).

## Architecture

```
Supabase (PostgreSQL)  ──Fivetran──▶  BigQuery (raw)  ──dbt──▶  staging ▸ intermediate ▸ marts
```

- **Ingestion** : [Fivetran](https://www.fivetran.com/) synchronise les tables de la base
  Supabase vers un dataset BigQuery.
- **Transformation** : dbt structure les données en trois couches.

## Structure dbt

| Couche | Dossier | Matérialisation | Rôle |
|--------|---------|-----------------|------|
| Staging | `models/staging/` | view | Nettoyage / renommage 1:1 des sources Fivetran |
| Intermediate | `models/intermediate/` | view | Logique métier réutilisable |
| Marts | `models/marts/` | table | Modèles d'analyse connectés au dashboard |

Les sources sont définies dans
[`models/staging/localbike/_localbike__sources.yml`](models/staging/localbike/_localbike__sources.yml).

## Configuration

Le projet tourne sous **dbt Cloud**. La connexion BigQuery est configurée dans l'UI
dbt Cloud (Connections / Environment) — pas de `profiles.yml` local.


## Commandes (dbt Cloud IDE / jobs)

```bash
dbt deps      # installe les packages
dbt build     # run + test
dbt docs generate   # documentation
```
