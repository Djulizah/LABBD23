USE sakila;

-- 1
create database genshin;
use genshin;
CREATE TABLE Element_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    element VARCHAR(255) NOT NULL
);
CREATE TABLE Weapon_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    weapon VARCHAR(255) NOT NULL
);
CREATE TABLE playable_characters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    isBuild BOOLEAN,
    element_id INT,
    weapon_id INT,
    FOREIGN KEY (element_id) REFERENCES Element_type(id),
    FOREIGN KEY (weapon_id) REFERENCES Weapon_type(id)
);

describe Element_type;
describe playable_characters;
describe Weapon_type;

-- NOMOR 2
INSERT INTO Element_type (element) VALUES
    ('anemo'),
    ('geo'),
    ('electro'),
    ('dendro'),
    ('hydro'),
    ('pyro'),
    ('cryo');
INSERT INTO Weapon_type (weapon) VALUES
    ('sword'),
    ('claymore'),
    ('polearm'),
    ('bow'),
    ('catalyst');
INSERT INTO playable_characters (name, isBuild, element_id, weapon_id) VALUES
    ('furina', true, 5, 1),   
    ('nahida', true, 4, 5),    
    ('xingqiu', true, 5, 1),  
    ('raiden shogun', false, 3, 3), 
    ('tartaglia', false, 5, 4),     
    ('sayu', false, 1, 2),           
    ('kokomi', false, 5, 5),        
    ('diona', false, 7, 4),           
    ('zhongli', false, 2, 3),         
    ('yoimiya', true, 6, 4),           
    ('venti', false, 1, 4),            
    ('ayaka', false, 7, 1);


-- 3
SELECT name, weapon
FROM playable_characters
JOIN Element_type ON playable_characters.element_id = Element_type.id
JOIN Weapon_type ON playable_characters.weapon_id = Weapon_type.id
WHERE Element_type.element = 'hydro';

DROP DATABASE GENSHIN;

-- 4 
SELECT
    staff.staff_id,
    CONCAT(staff.first_name, ' ', staff.last_name) AS 'Staff Name',
    COUNT(dew.customer_id) AS 'Staff Total Customer Count',
    (SUM(dew.money) * 0.8) AS 'Staff Income'
FROM
    payment 
inner join staff 
using(staff_id)
JOIN (
    SELECT
        sum(amount) as 'Money',
        customer_id,
        staff_id
    FROM
        payment
    GROUP BY
        customer_id
) AS dew
ON payment.customer_id = dew.customer_id and payment.staff_id = dew.staff_id
GROUP BY
    dew.staff_id
ORDER BY
    'Staff Income' DESC
LIMIT 1;


-- 5

SELECT 
	title,
	film_count,
	store_id
FROM (SELECT 
			film.title,
			inventory.store_id,
			COUNT(*) AS film_count,
			RANK() OVER(PARTITION BY inventory.store_id ORDER BY COUNT(*) DESC) AS rank
		FROM film
		JOIN inventory USING (film_id)
		GROUP BY film.title, inventory.store_id) AS ranked
WHERE rank = 1;

-- 6
SELECT distinct
    CASE
        WHEN ABS(TIMESTAMPDIFF(HOUR,'2006-02-23 05:00:00', updates.last_update)) > 24 
        THEN CONCAT_WS(',', DAYNAME(updates.last_update), DATE_FORMAT(updates.last_update, '%d %M %Y'))
        WHEN ABS(TIMESTAMPDIFF(HOUR,'2006-02-23 05:00:00', updates.last_update)) >= 1 
        THEN CONCAT_WS('Terakhir diupdate ', DAYNAME(updates.last_update), DATE_FORMAT(updates.last_update, 'Jam Lalu'))
        WHEN ABS(TIMESTAMPDIFF(MINUTE,'2006-02-23 05:00:00', updates.last_update)) >= 1 
        THEN CONCAT('Terakhir diupdate ', ABS(TIMESTAMPDIFF(MINUTE,'2006-02-23 05:00:00', updates.last_update)),  'Menit Lalu')
        
        ELSE CONCAT('Terakhir diupdate ', ABS(TIMESTAMPDIFF(second,'2006-02-23 05:00:00' , updates.last_update)), 'Detik lalu')
    END AS 'last_update', ACTION
    FROM(
		SELECT last_update, 'Perubahan Data Customer' AS 'Action' FROM customer
        UNION
        SELECT last_update, 'Perubahan Data Store' FROM store
        UNION
        SELECT last_update, 'Perubahan Data Payment' FROM payment
        UNION
        SELECT last_update, 'Perubahan Data Store' FROM rental
        UNION
        SELECT last_update, 'Perubahan Data Film' FROM film
        UNION
        SELECT last_update, 'Perubahan Data Actor' FROM actor
        UNION
        SELECT last_update, 'Perubahan Data Inventory' FROM inventory
    ) updates
ORDER BY updates.last_update DESC 
LIMIT 5;


-- 7
SELECT 
	c.name, 
	COUNT(f.film_id) jumlah_film, 
	SUM(p.amount) AS total_payment,
	CASE
		WHEN COUNT(f.film_id) > 1000 AND SUM(p.amount) > (SELECT AVG(total_payment)
			FROM (SELECT SUM(p.amount) AS total_payment
				FROM film f
				JOIN film_category fc ON f.film_id = fc.film_id
				JOIN category c ON fc.category_id = c.category_id
				JOIN inventory i ON f.film_id = i.film_id
				JOIN rental r ON i.inventory_id = r.inventory_id
				JOIN payment p ON r.rental_id = p.rental_id
			GROUP BY c.category_id) ab)
		THEN 'Kategori A Baik'
		
		WHEN COUNT(f.film_id) < 1000 AND SUM(p.amount) > (SELECT AVG(total_payment)
			FROM (SELECT SUM(p.amount) AS total_payment
				FROM film f
				JOIN film_category fc ON f.film_id = fc.film_id
				JOIN category c ON fc.category_id = c.category_id
				JOIN inventory i ON f.film_id = i.film_id
				JOIN rental r ON i.inventory_id = r.inventory_id
				JOIN payment p ON r.rental_id = p.rental_id
			GROUP BY c.category_id) ab)
		THEN 'Kategori A Kurang'
	END 'Keterangan'
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
WHERE LEFT(c.name,1)='A'
GROUP BY c.category_id
HAVING keterangan IS NOT NULL

UNION

SELECT
	c.name, 
	COUNT(f.film_id) jumlah_film, 
	SUM(p.amount) AS total_payment,
	CASE
		WHEN COUNT(f.film_id) > 1000 AND SUM(p.amount) > (SELECT AVG(total_payment) * 0.5
		FROM ( SELECT SUM(p.amount) AS total_payment
			FROM film f
			JOIN film_category fc ON f.film_id = fc.film_id
			JOIN category c ON fc.category_id = c.category_id
			JOIN inventory i ON f.film_id = i.film_id
			JOIN rental r ON i.inventory_id = r.inventory_id
			JOIN payment p ON r.rental_id = p.rental_id
		GROUP BY c.category_id) ab)
		THEN 'Kategori C Baik'
		
		WHEN COUNT(f.film_id) < 1000 AND SUM(p.amount) > (SELECT AVG(total_payment) * 0.5
		FROM (SELECT SUM(p.amount) AS total_payment
			FROM film f
			JOIN film_category fc ON f.film_id = fc.film_id
			JOIN category c ON fc.category_id = c.category_id
			JOIN inventory i ON f.film_id = i.film_id
			JOIN rental r ON i.inventory_id = r.inventory_id
			JOIN payment p ON r.rental_id = p.rental_id
		GROUP BY c.category_id) ab)
		THEN 'Kategori C Kurang'
	END 'Keterangan'
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
WHERE LEFT(c.name,1)='C'
GROUP BY c.category_id
HAVING keterangan IS NOT NULL

UNION

SELECT 
	c.name, 
	COUNT(f.film_id) jumlah_film, 
	SUM(p.amount) AS total_payment,
	CASE
		WHEN COUNT(f.film_id) > 1000 AND SUM(p.amount) > (SELECT MIN(total_payment)
		FROM (SELECT SUM(p.amount) AS total_payment
			FROM film f
			JOIN film_category fc ON f.film_id = fc.film_id
			JOIN category c ON fc.category_id = c.category_id
			JOIN inventory i ON f.film_id = i.film_id
			JOIN rental r ON i.inventory_id = r.inventory_id
			JOIN payment p ON r.rental_id = p.rental_id
		GROUP BY c.category_id) ab)
		THEN 'Kategori D Baik'
		
		WHEN COUNT(f.film_id) < 1000 AND SUM(p.amount) > (SELECT MIN(total_payment)
		FROM (SELECT SUM(p.amount) AS total_payment
			FROM film f
			JOIN film_category fc ON f.film_id = fc.film_id
			JOIN category c ON fc.category_id = c.category_id
			JOIN inventory i ON f.film_id = i.film_id
			JOIN rental r ON i.inventory_id = r.inventory_id
			JOIN payment p ON r.rental_id = p.rental_id
		GROUP BY c.category_id) ab)
		THEN 'Kategori D Kurang'
	END 'Keterangan'
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
WHERE LEFT(c.name,1)='D'
GROUP BY c.category_id
HAVING keterangan IS NOT NULL
