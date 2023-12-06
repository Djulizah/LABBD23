-- Nomor 1
CREATE DATABASE GENSHIN; 
USE GENSHIN

CREATE TABLE playable_characters(
			id INT PRIMARY KEY AUTO_INCREMENT,
			`name` VARCHAR (255),
			isBuild BOOLEAN,
			element_id INT,
			weapon_id INT,
			FOREIGN KEY(element_id) REFERENCES Element_type(id), 
			FOREIGN KEY(weapon_id) REFERENCES Weapon_type(id)
);
		
CREATE TABLE Element_type(
			id INT PRIMARY KEY AUTO_INCREMENT,
			element VARCHAR (255)
);
		
CREATE TABLE Weapon_type (
			id INT PRIMARY KEY AUTO_INCREMENT,
			weapon VARCHAR (255)
);



-- Nomor 2
INSERT INTO element_type(element)
VALUES('anemo'), ('geo'), ('electro'), ('dendro'), ('hydro'), ('pyro'), ('cryo');

INSERT INTO weapon_type(weapon)
VALUES ('sword'), ('claymore'), ('polearm'), ('bow'), ('catalyst');

INSERT INTO playable_characters(`name`, isBuild, element_id, weapon_id)
VALUES('furina', TRUE, 5, 1),
						('nahida', TRUE, 4, 5),
						('xingqiu', TRUE, 5, 1),
						('raiden shogun', FALSE, 3, 3),
						('tartaglia', FALSE, 5, 4),
						('sayu', FALSE, 1, 2),
						('kokomi', FALSE, 4, 5),
						('diona', FALSE, 7, 4),
						('zhongli', FALSE, 2, 3),
						('yoimiya', TRUE, 6, 4),
						('venti', FALSE, 1, 4),
						('ayaka', FALSE, 7, 1);



-- Nomor 3
SELECT pc.name, wt.weapon
FROM playable_characters AS pc
JOIN weapon_type AS wt 
ON pc.weapon_id = wt.id
WHERE pc.element_id = 5

		
		
-- Nomor 4
USE sakila;			

SELECT
    staff.staff_id,
    CONCAT(staff.first_name, ' ', staff.last_name) AS 'Staff Name',
    COUNT(tp.customer_id) AS 'Staff Total Customer Count',
    (SUM(tp.pendapatan) * 0.8) AS 'Staff Income'
FROM payment 
JOIN staff USING(staff_id)
JOIN (
	    SELECT
	        SUM(amount) AS 'pendapatan',
	        customer_id,
	        staff_id
	    FROM payment
	    GROUP BY customer_id
		) AS tp
ON payment.customer_id = tp.customer_id AND payment.staff_id = tp.staff_id
GROUP BY tp.staff_id
ORDER BY 'Staff Income' DESC
LIMIT 1;



-- Nomor 5
SELECT title, film_count, store_id
FROM (SELECT film.title, inventory.store_id, COUNT(*) AS film_count, 
						RANK() OVER(PARTITION BY inventory.store_id ORDER BY COUNT(*) DESC) AS `rank`
						FROM film
						JOIN inventory USING (film_id)
						GROUP BY film.title, inventory.store_id) AS ranked
WHERE `rank` = 1;



-- Nomor 6
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



-- Nomor 7
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
			
