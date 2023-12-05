-- NO 1

CREATE DATABASE genshin;
USE genshin;

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
	`name` VARCHAR(255) NOT NULL,
	isBuild BOOLEAN,
	element_id INT,
	weapon_id INT,
	FOREIGN KEY (element_id) REFERENCES Element_type(id),
	FOREIGN KEY (weapon_id) REFERENCES Weapon_type(id)
);


-- NO. 2

INSERT INTO Element_type (element)
VALUES ('hydro'),
		 ('dendro'),
		 ('electro'),
		 ('anemo'),
		 ('cryo'),
		 ('geo'),
		 ('pyro');
		 
SELECT * FROM Element_type;

INSERT INTO Weapon_type (weapon)
VALUES ('sword'),
		 ('catalyst'),
		 ('polearm'),
		 ('bow'),
		 ('claymore');
		 
SELECT * FROM Weapon_type;
		 
INSERT INTO playable_characters (`name`, isBuild, element_id, weapon_id)
VALUES ('furina', TRUE, 1, 1),
		 ('nahida', TRUE, 2, 2),
		 ('xingqiu', TRUE, 1, 1),
		 ('raiden shogun', FALSE, 3, 3),
		 ('tartaglia', FALSE, 1, 4),
		 ('sayu', FALSE, 4, 5),
		 ('kokomi', FALSE, 1, 2),
		 ('diona', FALSE, 5, 4),
		 ('zhongli', FALSE, 6, 3),
		 ('yoimiya', TRUE, 7, 4),
		 ('venti', FALSE, 4, 4),
		 ('ayaka', FALSE, 5, 1);

SELECT * FROM playable_characters;


-- NO 3

SELECT 
	`name`,
	weapon
FROM playable_characters
JOIN element_type 
ON playable_characters.element_id = element_type.id
JOIN weapon_type
ON playable_characters.weapon_id = weapon_type.id
WHERE element_type.element = 'hydro';

DROP DATABASE genshin;


-- NO 4

SELECT 
	staff.staff_id,
	CONCAT(staff.first_name, ' ', staff.last_name) AS 'Staff Name',
	COUNT(customer.customer_id) AS 'Staff Total Customer Count',
	SUM(payment.amount) AS 'Staff Income'
FROM staff 
JOIN payment  USING (staff_id)
JOIN rental  USING (rental_id)
JOIN customer  ON customer.customer_id = rental.customer_id
GROUP BY staff.staff_id
HAVING SUM(payment.amount) * 0.8
ORDER BY `Staff Income` DESC 
LIMIT 1;


-- NO 5

SELECT 
	title,
	film_count,
	store_id
FROM (SELECT 
			film.title,
			inventory.store_id,
			COUNT(*) AS film_count,
			RANK() OVER(PARTITION BY inventory.store_id ORDER BY COUNT(*) DESC) AS `rank`
		FROM film
		JOIN inventory USING (film_id)
		GROUP BY film.title, inventory.store_id) AS ranked
WHERE `rank` = 1;
			
			
-- NO 6

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


-- NO 7

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
HAVING `keterangan` IS NOT NULL

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
HAVING `keterangan` IS NOT NULL

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
HAVING `keterangan` IS NOT NULL
											