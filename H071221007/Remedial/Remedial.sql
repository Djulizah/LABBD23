-- No 1
CREATE DATABASE GENSHIN;
USE GENSHIN;

CREATE TABLE playable_characters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    isBuild BOOLEAN,
    element_id INT,
    weapon_id INT,
    FOREIGN KEY (element_id) REFERENCES Element_type(id),
    FOREIGN KEY (weapon_id) REFERENCES Weapon_type(id)
);

CREATE TABLE Element_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    element VARCHAR(50)
);

CREATE TABLE Weapon_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    weapon VARCHAR(50)
);



-- no 2
INSERT INTO Element_type (element) VALUES 
('anemo'), ('geo'), ('electro'), ('dendro'), ('hydro'), ('pyro'), ('cryo');

INSERT INTO Weapon_type (weapon) VALUES 
('sword'), ('claymore'), ('polearm'), ('bow'), ('catalyst');

INSERT INTO playable_characters (name, isBuild, element_id, weapon_id) VALUES
('furina', TRUE, 5, 1),
('nahida', TRUE, 4, 5),
('xingqiu', TRUE, 5, 1),
('raiden shogun', FALSE, 3, 3),
('tartaglia', FALSE, 5, 4),
('sayu', FALSE, 1, 4),
('kokomi', FALSE, 5, 5),
('diona', FALSE, 7, 4),
('zhongli', FALSE, 2, 3),
('yoimiya', TRUE, 6, 4),
('venti', FALSE, 1, 4),
('ayaka', FALSE, 7, 1);





-- no3
SELECT name, w.weapon AS weapon
FROM playable_characters p
JOIN Element_type e ON p.element_id = e.id
JOIN Weapon_type w ON p.weapon_id = w.id
WHERE e.element = 'hydro';

DROP DATABASE GENSHIN;





-- no4
-- tdk tau ini outputnya kak, tdk bisai jalan
SELECT
    staff.staff_id,
    CONCAT(staff.first_name, ' ', staff.last_name) AS 'Staff Name',
    COUNT(subquery.customer_id) AS 'Staff Total Customer Count',      
	 (SUM(subquery.money) * 0.8) AS 'Staff Income'
FROM payment 
INNER JOIN staff USING(staff_id)  
	JOIN (
    	SELECT SUM(amount) as 'money',
        customer_id,
        staff_id 
		  FROM payment 
		  GROUP BY customer_id
) AS subquery 
ON payment.customer_id = subquery.customer_id AND payment.staff_id = subquery.staff_id 
GROUP BY subquery.staff_id
ORDER BY `Staff Income` DESC
LIMIT 1;
-- error ki database ku kak, biar gini tdk bisa jg, yg lain jg tiba tiba hilang jadi 0 semua baru tdk bisa terakses, biar kode ini tdk bisa jalan
SELECT * FROM film;
SHOW DATABASE sakila;






-- no5
SELECT DISTINCT f.title, film_count, i.store_id
FROM (
   SELECT film_id, COUNT(*) AS film_count, store_id
   FROM inventory
   GROUP BY film_id, store_id
	) AS film_inventory
JOIN 
    film f ON f.film_id = film_inventory.film_id
JOIN 
    inventory i ON film_inventory.film_id = i.film_id AND film_inventory.store_id = i.store_id
WHERE film_count = (
    SELECT DISTINCT
        MAX(film_count) AS max_count
    FROM (
        SELECT film_id, COUNT(*) AS film_count FROM inventory
        GROUP BY film_id, store_id) AS a);

  
  
  
  
  

-- no6
SELECT DISTINCT
    CASE
        WHEN ABS(TIMESTAMPDIFF(HOUR,'2006-02-23 05:00:00', updates.last_update)) > 24 
        		THEN CONCAT_WS(',', DAYNAME(updates.last_update), DATE_FORMAT(updates.last_update, ' %d %M %Y'))
        WHEN ABS(TIMESTAMPDIFF(HOUR,'2006-02-23 05:00:00', updates.last_update)) >= 1 
        		THEN CONCAT_WS('Terakhir di update ', DAYNAME(updates.last_update), DATE_FORMAT(updates.last_update, ' jam Lalu'))
        WHEN ABS(TIMESTAMPDIFF(MINUTE,'2006-02-23 05:00:00', updates.last_update)) >= 1 
        		THEN CONCAT('Terakhir di update ', abs(timestampdiff(minute,'2006-02-23 05:00:00', updates.last_update)),  ' menit Lalu')

        ELSE CONCAT('Terakhir di update ', ABS(TIMESTAMPDIFF(second,'2006-02-23 05:00:00' , updates.last_update)), ' detik lalu')
    END AS 'last_update', ACTION
    FROM(
			SELECT last_update, 'Perubahan pada data customer' AS 'Action' FROM customer
	      UNION 
	      SELECT  last_update, 'Perubahan pada data store' FROM store
	      UNION 
	      SELECT  last_update, 'Perubahan pada data payment' FROM payment
	      UNION 
	      SELECT last_update, 'Perubahan pada data store' FROM rental
	      UNION 
	      SELECT last_update, 'Perubahan pada data film' FROM film
	      UNION
	      SELECT last_update, 'Perubahan pada data actor' FROM actor
	      UNION
	      SELECT last_update, 'Perubahan pada data inventory' FROM inventory
    ) updates
ORDER BY updates.last_update DESC 
LIMIT 5;





-- no7
SELECT 
    c.name AS nama,
    COUNT(DISTINCT f.film_id) AS jumlah_film,
    SUM(p.amount) AS total_payment,
    CASE 
        WHEN c.name LIKE 'A%' AND COUNT(f.film_id) > 1000 AND SUM(p.amount) > (SELECT AVG(amount) FROM payment) THEN 'Kategori A Baik'
        WHEN c.name LIKE 'A%' AND COUNT(f.film_id) < 1000 AND SUM(p.amount) < (SELECT AVG(amount) FROM payment) THEN 'Kategori A Kurang'
        WHEN c.name LIKE 'C%' AND COUNT(f.film_id) > 1000 AND SUM(p.amount) > (SELECT AVG(amount) FROM payment) * 0.5 THEN 'Kategori C Baik'
        WHEN c.name LIKE 'C%' AND COUNT(f.film_id) < 1000 AND SUM(p.amount) > (SELECT AVG(amount) FROM payment) * 0.5 THEN 'Kategori C Kurang'
        WHEN c.name LIKE 'D%' AND COUNT(f.film_id) > 1000 AND SUM(p.amount) > (SELECT MIN(amount) FROM payment) THEN 'Kategori D Baik'
        WHEN c.name LIKE 'D%' AND COUNT(f.film_id) < 1000 AND SUM(p.amount) > (SELECT MIN(amount) FROM payment) THEN 'Kategori D Kurang'
    END AS keterangan
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    payment p ON i.inventory_id = p.customer_id
GROUP BY 
    c.name
HAVING
	keterangan IS NOT NULL
ORDER BY 
    nama;
    
    
