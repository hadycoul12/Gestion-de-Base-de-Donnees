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
SELECT *
FROM orders
WHERE status = 'completed'
AND order_date BETWEEN "2022-01-01" AND "2022-12-31";

