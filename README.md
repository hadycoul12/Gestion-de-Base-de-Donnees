# Analyse des Ventes Retail

## Introduction

Dans un contexte où les entreprises s’appuient de plus en plus sur les données pour guider leurs décisions, la maîtrise du langage SQL devient une compétence essentielle pour tout analyste ou data engineer.

Ce projet a été conçu comme une ressource pédagogique appliquée, centrée sur un cas réel du secteur Retail. Plutôt que de lister des commandes SQL de manière théorique, ce notebook propose une approche contextuelle et progressive à travers des scénarios concrets d’analyse commerciale.

À partir d’un jeu de données simulant des ventes e-commerce, nous explorons une série de questions stratégiques – du calcul du chiffre d’affaires à l’identification des meilleurs clients, en passant par l’évolution annuelle des ventes.


---


## 🎯 Objectif du projet

Utiliser un jeu de données simulé du e-commerce pour :

- Explorer les commandes, produits et clients via SQL
- Répondre à des questions analytiques business
- Maîtriser les différentes commandes SQL du niveau **débutant à avancé**
- Comprendre l’utilité métier de chaque requête


---


## Jeu de données

Le jeu de données est constitué de 4 tables principales :

- `customers.csv` → Données clients (nom, email, date d’inscription…)
- `products.csv` → Détails produits (nom, catégorie, prix…)
- `orders.csv` → Commandes (client, date, statut…)
- `order_details.csv` → Détail des commandes (produits, quantités…)


---


## Questions analysées

Voici un aperçu des analyses menées dans le notebook :

- Chiffre d’affaires par mois / année
- Montant total et moyen des ventes
- Nombre de clients actifs par période
- Produits vendus l’année précédente mais plus maintenant
- Taux de croissance annuel
- Top clients par volume d’achat
- Répartition des ventes par catégorie


---


## Structure du notebook

Le notebook est organisé par **niveaux de complexité SQL** :

### 🟢 Niveau Débutant
- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`

### 🟠 Niveau Intermédiaire
- `JOIN`, `GROUP BY`, `HAVING`, `CASE` , fonctions d’agrégation, Gestion des valeurs nulles, Opérations ensemblistes, Changement de type de données avec CAST, Format de date


### 🔵 Niveau Avancé
- **CTE** (`WITH`)
- **Sous-requêtes**
- **Fenêtres analytiques** (`OVER PARTITION BY`, etc.)
- PIVOT, UNPIVOT

Chaque requête est accompagnée de :
- Une **question métier claire**
- Une **commande SQL commentée**
- Une **interprétation des résultats**


---


## 👨‍💻 Auteur

**Hady Coulibaly**  
Étudiant en Data & passionné par l’ingénierie des données

📬 Intéressé par une collaboration technique ou une discussion data ?  
🔗 [Visitez mon Portfolio ici](https://hady-data-showcase.lovable.app/)

---

## 📎 Liens utiles

- [Documentation SQL officielle (PostgreSQL)](https://www.postgresql.org/docs/)
- [Open SQL Tutorial – Mode interactif](https://sqlbolt.com/)
