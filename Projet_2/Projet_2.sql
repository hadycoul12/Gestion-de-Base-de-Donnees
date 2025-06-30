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

				INNER JOIN, LEFT JOIN
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





