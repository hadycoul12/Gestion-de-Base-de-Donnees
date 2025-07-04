-- Syntaxe de base

SELECT * FROM new_tuto.customers;

-- Sélectionner la colonne email de la table customers
SELECT 
	email
FROM customers;

-- Sélectionner les commandes avec le statut 'Completed'
SELECT *
FROM orders
WHERE status = "completed";

-- Trouver des clients avec des adresses email provenant de 'example.com'
SELECT 
	customer_id
FROM customers
WHERE email LIKE "%example.com";


-- Sélectionner des produits (id et name) dans les catégories 'Electronics' ou 'Clothing'
SELECT 
	product_id,
    product_name
FROM 
	products
WHERE 
	category = 'Electronics' OR 'Clothing';

-- OU une autre possibilité
SELECT 
	product_id,
    product_name
FROM 
	products
WHERE 
	category IN ( 'Electronics', 'Clothing');
    
-- Commandes effectuées entre le 1er janvier 2022 et le 31 décembre 2022

SELECT order_id
FROM orders
WHERE order_date BETWEEN "2022-01-01" AND "2022-12-31";

-- Clients n'ayant pas fourni d'adresse email
SELECT 
	customer_id,
    first_name,
    last_name
FROM customers
WHERE email IS NULL;

-- Commandes complétées en 2022 
SELECT order_id
FROM orders
WHERE status = 'completed'
AND order_date BETWEEN "2022-01-01" AND "2022-12-31";

-- Commandes en août 2022 ou décembre 2022
SELECT order_id
FROM orders
WHERE (order_date BETWEEN "2022-08-01" AND "2022-08-31")
OR (order_date BETWEEN "2022-12-01" AND "2022-12-31") ;

-- Commandes qui ne sont pas en mai, juin et juillet 2022
SELECT 
	order_id,
	customer_id,
	order_date
FROM orders
WHERE NOT order_date BETWEEN '2022-05-01' AND '2022-07-31';




/*==========================================================================================
                Tri et affichage de données
							ORDER BY
==========================================================================================*/

-- Trier les produits du plus cher au moins cher
SELECT 
	product_id,
	price
FROM products
ORDER BY price DESC;

-- Trois produits les plus chers
SELECT
	product_id,
    price
FROM products
ORDER BY price DESC
LIMIT 3;

-- Ignorer les 5 premiers et fournir les 3 suivants
SELECT
	product_id,
    price
FROM products
ORDER BY price DESC
LIMIT 3
OFFSET 5;





/*==========================================================================================
							  Regroupement
							   GROUP BY
==========================================================================================*/

-- Nombre de commandes par client
SELECT
	customer_id,
	COUNT(order_id) AS 'Nbre commandes'
FROM orders
WHERE status = 'completed'
GROUP BY customer_id;


-- Les clients qui ont plus de 5 commandes
SELECT
	customer_id,
    COUNT(order_id) AS 'Nbre_commandes'
FROM orders
WHERE status = 'completed'
GROUP BY customer_id
HAVING Nbre_commandes > 5;


/*==========================================================================================
							Agrégation
					SUM, AVG, MIN, MAX, COUNT, DISTINCT
==========================================================================================*/

-- Ventes totales, quantité moyenne, prix minimum et maximum, le nombre de produits distincts par commande
SELECT
	order_id,
    SUM(quantity * unit_price) AS 'Vte_tot',
    AVG(quantity) AS 'Q_moy',
    MIN(unit_price) AS 'Prix_min',
    MAX(unit_price) AS 'Prix_max',
    COUNT(DISTINCT product_id) AS 'Nbre_Produits'
FROM order_details
GROUP BY order_id;
    
    
    
    
/*==========================================================================================
							Intermédiaire (Les jointures)

				INNER JOIN, LEFT JOIN,  SELF JOIN, FULL OUTER JOIN, CROSS JOIN
==========================================================================================*/

-- INNER JOIN entre customers et orders, pour récupérer les clients qui ont passés la commande
SELECT
	customers.*,
    orders.order_id,
    orders.order_date,
    orders.status
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE status = 'completed';


-- Afficher tous les clients et leurs commandes, s'ils en ont
SELECT
	customers.*,
    orders.order_id,
    orders.order_date,
    orders.status
FROM customers 
LEFT JOIN orders 
ON customers.customer_id = orders.customer_id
WHERE status = 'completed';


-- SELF JOIN pour trouver des pairs de clients qui arrivent à la même date
SELECT 
	c1.customer_id AS id_client1,
    c1.first_name AS prenom_client1,
    c1.last_name AS nom_client1,
    c2.customer_id AS id_client2,
    c2.first_name AS prenom_client2,
    c2.last_name AS nom_client2,
    c1.join_date
FROM customers c1
INNER JOIN customers c2
ON c1.customer_id < c2.customer_id
AND c1.join_date = c2.join_date;



-- FULL OUTER JOIN récupère tous les clients et toutes les commandes,

SELECT 
	c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date
FROM customers c 
FULL OUTER JOIN 
ON c.customer_id = o.customer_id;





/*==========================================================================================
							Opérations ensemblistes
					UNION, INTERSECT, EXCEPT
==========================================================================================*/


-- UNION pour combiner deux ou plusieurs tables
SELECT
	'customers' AS table_name,
    COUNT(customer_id) AS Nombre
FROM customers

UNION

SELECT 
	'products' AS table_name,
    COUNT(product_id) AS Nombre
FROM products

UNION

SELECT 
	'orders' AS table_name,
    COUNT(order_id) AS Nombre
FROM orders;



-- Trouver des clients qui ont commandé en 2023 et 2022
SELECT 
	customer_id
FROM orders
WHERE strftime('%Y', order_date) = '2023'

INTERSECT

SELECT 
	customer_id
FROM orders
WHERE strftime('%Y', order_date) = '2022';

-- Il me semble que strftime est une fonction spécifique à SQLite, MySQL ne supporte pas INTERSECT non plus. J'ai fais recours à une autre alternative ci-dessous avec la fonction YEAR et GROUP BY

SELECT customer_id
FROM orders
WHERE YEAR(order_date) IN (2022, 2023)
GROUP BY customer_id
HAVING COUNT(DISTINCT YEAR(order_date)) = 2;



-- Trouver les produits qui ne sont pas vendus en 2023
SELECT product_id
FROM products

EXCEPT

SELECT product_id
FROM order_details
WHERE order_id IN (SELECT order_id FROM orders WHERE YEAR(order_date) = 2023)




/*==========================================================================================
							Gestion des valeurs nulles
								NULLIF, COALESCE
==========================================================================================*/





/*==========================================================================================
						Changement de type de données avec CAST
			Pratique pour convertir les string à integer ou string à date.
==========================================================================================*/

-- Convertir les années de commande en integer, pour effectuer les calculs

SELECT 
    order_id,      
    order_date,     
    CAST(YEAR(order_date) AS UNSIGNED) AS year,       
    CAST(YEAR(order_date) AS UNSIGNED) + 1 AS following_year 
FROM orders;


/*==========================================================================================
					Logique conditionnelle avec CASE
		Combiner CASE avec des agrégations : SUM, COUNT, AVG, MIN, MAX, DISTINCT
==========================================================================================*/

SELECT
	COUNT(DISTINCT CASE WHEN status = 'Completed' THEN order_id END) AS Nbr_commande_complète,
    SUM(DISTINCT CASE WHEN status = 'Completed' THEN d.unit_price * d.quantity ELSE 0 END) AS Vente_total_commande_complète,
    AVG(DISTINCT CASE WHEN status = 'Completed' THEN d.unit_price * d.quantity ELSE 0 END) AS Vente_Moyen_commande_complète,
	MIN(DISTINCT CASE WHEN status = 'Completed' THEN d.unit_price * d.quantity ELSE 0 END) AS Vente_MIN_commande_complète,
    MAX(DISTINCT CASE WHEN status = 'Completed' THEN d.unit_price * d.quantity ELSE 0 END) AS Vente_MAX_commande_complète
FROM orders o
JOIN order_details d
USING(order_id);





/*==========================================================================================
						Format de date
			DATE_ADD,  DATEDIFF
==========================================================================================*/

-- Ajouter 7 jours à la date de la commande pour obtenir la date de paiement

SELECT 
	order_id,
    order_date,
DATE_ADD(order_date, INTERVAL 7 DAY) AS Date_payement
FROM orders;


-- Calculer le nombre de jours entre la date de la commande et aujourd'hui AVEC DATEDIFF

SELECT 
	order_id,
    order_date,
DATEDIFF(CURRENT_DATE, order_date) AS Nbr_jour_écoulés_depuis_commande
FROM orders
LIMIT 15;
