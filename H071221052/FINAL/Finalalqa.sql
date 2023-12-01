-- AL QADRI
-- H071221052
-- UJIAN 

-- NOMOR 1
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

select * from playable_characters;
select * from Element_type;
select * from Weapon_type;

-- NOMOR 3
SELECT name, weapon
FROM playable_characters
JOIN Element_type ON playable_characters.element_id = Element_type.id
JOIN Weapon_type ON playable_characters.weapon_id = Weapon_type.id
WHERE Element_type.element = 'hydro';
-- MENGHAPUS DATABASE GENSHIN
DROP DATABASE GENSHIN;

-- NOMOR 4
USE SAKILA;
SELECT
    staff.staff_id,
    CONCAT(staff.first_name, ' ', staff.last_name) AS 'Staff Name',
    COUNT(subquery.customer_id) AS 'Staff Total Customer Count',
    (SUM(subquery.money) * 0.8) AS 'Staff Income'
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
) AS subquery 
ON payment.customer_id = subquery.customer_id and payment.staff_id = subquery.staff_id
GROUP BY
    subquery.staff_id
ORDER BY
    'Staff Income' DESC
LIMIT 1;


-- NOMOR 5
use sakila;
select * from film;
select * from inventory;
SELECT
  title,
  film_count,
  store_id
FROM (
  SELECT
    f.title,
    i.store_id,
    COUNT(*) AS film_count,
    RANK() OVER (PARTITION BY i.store_id ORDER BY COUNT(*) DESC) AS ranking
  FROM
    film f
    JOIN inventory i ON f.film_id = i.film_id
  GROUP BY
    f.title, i.store_id
) AS RankedFilmInventory
WHERE
  ranking = 1;

-- NOMOR 6  
SELECT distinct
    CASE
        WHEN ABS(TIMESTAMPDIFF(HOUR,'2006-02-23 05:00:00', updates.last_update)) > 24 
        THEN CONCAT_WS(',', DAYNAME(updates.last_update), DATE_FORMAT(updates.last_update, '%d %M %Y'))
        WHEN ABS(TIMESTAMPDIFF(HOUR,'2006-02-23 05:00:00', updates.last_update)) >= 1 
        THEN CONCAT_WS('Terakhir diupdate ', DAYNAME(updates.last_update), DATE_FORMAT(updates.last_update, 'Jam Lalu'))
        WHEN ABS(TIMESTAMPDIFF(MINUTE,'2006-02-23 05:00:00', updates.last_update)) >= 1 
        THEN CONCAT('Terakhir diupdate ', abs(timestampdiff(minute,'2006-02-23 05:00:00', updates.last_update)),  'Menit Lalu')
        
        ELSE CONCAT('Terakhir diupdate ', ABS(TIMESTAMPDIFF(second,'2006-02-23 05:00:00' , updates.last_update)), 'Detik lalu')
    END AS 'last_update', Action
    From(
		select last_update, 'Perubahan Data Customer' as 'Action' from customer
        union
        select last_update, 'Perubahan Data Store' from store
        union
        select last_update, 'Perubahan Data Payment' from payment
        union
        select last_update, 'Perubahan Data Store' from rental
        union
        select last_update, 'Perubahan Data Film' from film
        union
        select last_update, 'Perubahan Data Actor' from actor
        union
        select last_update, 'Perubahan Data Inventory' from inventory
    ) updates
ORDER BY updates.last_update desc 
limit 5;

-- Nomor 7
use sakila;
SELECT
    c.name AS nama,
    COUNT(f.film_id) AS jumlah_film,
    SUM(p.amount) AS total_payment,
    CASE
        WHEN c.name LIKE 'A%' AND COUNT(f.film_id) > 1000 AND SUM(p.amount) > (SELECT AVG(amount) FROM payment) THEN 'Kategori A Baik'
        WHEN c.name LIKE 'A%' AND COUNT(f.film_id) < 1000 AND SUM(p.amount) < (SELECT AVG(amount) FROM payment) THEN 'Kategori A Kurang'
        WHEN c.name LIKE 'C%' AND COUNT(f.film_id) > 1000 AND SUM(p.amount) > (SELECT AVG(amount) FROM payment) * 0.5 THEN 'Kategori C Baik'
        WHEN c.name LIKE 'C%' AND COUNT(f.film_id) < 1000 AND SUM(p.amount) > (SELECT AVG(amount) FROM payment) * 0.5 THEN 'Kategori C Kurang'
        WHEN c.name LIKE 'D%' AND COUNT(f.film_id) > 1000 AND SUM(p.amount) > (SELECT MIN(amount) FROM payment) THEN 'Kategori D Baik'
        WHEN c.name LIKE 'D%' AND COUNT(f.film_id) < 1000 AND SUM(p.amount) > (SELECT MIN(amount) FROM payment) THEN 'Kategori D Kurang'
        ELSE 'Kategori Lainnya'
    END AS keterangan
FROM
    film f
 join inventory i
 using(film_id)
 join rental r
 using(inventory_id)
JOIN
    payment p 
    using(rental_Id)

    join film_category fc
    using(film_id)
    join category c
    using(category_id)
GROUP BY
    c.name
    limit 7;
    
    -- versi 2 heheuw
    SELECT
    c.name AS nama,
    COUNT(f.film_id) AS jumlah_film,
    SUM(p.amount) AS total_payment,
    CASE
        WHEN c.name LIKE 'A%' AND COUNT(f.film_id) > 1000 AND SUM(p.amount) > (SELECT AVG(amount) FROM payment) THEN 'Kategori A Baik'
        WHEN c.name LIKE 'A%' AND COUNT(f.film_id) < 1000 AND SUM(p.amount) < (SELECT AVG(amount) FROM payment) THEN 'Kategori A Kurang'
        WHEN c.name LIKE 'C%' AND COUNT(f.film_id) > 1000 AND SUM(p.amount) > (SELECT AVG(amount) FROM payment) * 0.5 THEN 'Kategori C Baik'
        WHEN c.name LIKE 'C%' AND COUNT(f.film_id) < 1000 AND SUM(p.amount) < (SELECT AVG(amount) FROM payment) * 0.5 THEN 'Kategori C Kurang'
        WHEN c.name LIKE 'D%' AND COUNT(f.film_id) > 1000 AND SUM(p.amount) > (SELECT MIN(amount) FROM payment) THEN 'Kategori D Baik'
        WHEN c.name LIKE 'D%' AND COUNT(f.film_id) < 1000 AND SUM(p.amount) < (SELECT MIN(amount) FROM payment) THEN 'Kategori D Kurang'
        ELSE 'Kategori Lainnya'
    END AS keterangan
FROM
    film f
JOIN
    inventory i USING (film_id)
JOIN
    rental r USING (inventory_id)
JOIN
    payment p USING (rental_id)
JOIN
    film_category fc USING (film_id)
JOIN
    category c USING (category_id)
GROUP BY
    c.name
    limit 7;
    
    
SELECT
    staff.staff_id,
    CONCAT(staff.first_name, ' ', staff.last_name) AS 'Staff Name',
	count(customer.customer_id) as 'Staff Total Customer Count',
    FORMAT(SUM(payment.amount) * 0.8, 3) AS 'Staff Income'
FROM
    staff
JOIN
    payment ON staff.staff_id = payment.staff_id
JOIN
    customer 
    using(customer_id)
GROUP BY
    customer.customer_id
ORDER BY
    'Staff Income' DESC
LIMIT 1;

