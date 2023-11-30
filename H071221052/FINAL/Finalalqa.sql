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
-- SELECT
--     staff.staff_id,
--     CONCAT(staff.first_name, ' ', staff.last_name) AS 'Staff Name',
--     COUNT(rental.rental_id) AS 'Staff Total Customer Count',
--     SUM(payment.amount * 0.8) AS 'Staff Income'
-- FROM
--     staff
-- JOIN
--     payment ON staff.staff_id = payment.staff_id
-- JOIN
--     rental ON payment.rental_id = rental.rental_id
-- GROUP BY
--     staff.staff_id
-- ORDER BY
--     'Staff Income' DESC
-- LIMIT 1;

SELECT
    staff.staff_id,
    CONCAT(staff.first_name, ' ', staff.last_name) AS 'Staff Name',
    COUNT(customer.customer_id) AS 'Staff Total Customer Count',
    SUM(rental.customer_id * 0.8) AS 'Staff Income'
FROM
    staff
JOIN
    payment ON staff.staff_id = payment.staff_id
JOIN
    rental ON payment.rental_id = rental.rental_id
JOIN
    customer ON rental.customer_id = customer.customer_id
GROUP BY
    staff.staff_id
ORDER BY
    'Staff Income' DESC
LIMIT 1;

SELECT
    staff.staff_id,
    CONCAT(staff.first_name, ' ', staff.last_name) AS 'Staff Name',
    COUNT(subquery.customer_id) AS 'Staff Total Customer Count',
    SUM(subquery.total_rental * 0.8) AS 'Staff Income'
FROM
    staff
JOIN (
    SELECT
        payment.staff_id,
        rental.customer_id,
        COUNT(rental.rental_id) AS total_rental
    FROM
        payment
    JOIN
        rental ON payment.rental_id = rental.rental_id
    GROUP BY
        payment.staff_id, rental.customer_id
) AS subquery ON subquery.staff_id = staff.staff_id
GROUP BY
    staff.staff_id
ORDER BY
    'Staff Income' DESC
LIMIT 1;
-- ada dua jawaban ini kak, nda tau mana benar

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
-- SELECT
--     CASE
--         WHEN TIMESTAMPDIFF(SECOND, MAX(last_update), NOW()) < 60 THEN CONCAT('Terakhir diupdate ', TIMESTAMPDIFF(SECOND, MAX(last_update), NOW()), ' detik lalu')
--         WHEN TIMESTAMPDIFF(MINUTE, MAX(last_update), NOW()) < 60 THEN CONCAT('Terakhir diupdate ', TIMESTAMPDIFF(MINUTE, MAX(last_update), NOW()), ' menit lalu')
--         WHEN TIMESTAMPDIFF(HOUR, MAX(last_update), NOW()) < 24 THEN CONCAT('Terakhir diupdate ', TIMESTAMPDIFF(HOUR, MAX(last_update), NOW()), ' jam lalu')
--         ELSE CONCAT('Terakhir diupdate ', DATE_FORMAT(MAX(last_update), '%W, %d %M %Y'))
--     END AS last_update,
--     CONCAT('Perubahan pada data ', table_name) AS action
-- FROM (
--     SELECT last_update, 'store' AS table_name FROM store
--     UNION ALL
--     SELECT last_update, 'payment' FROM payment
--     UNION ALL
--     SELECT last_update, 'rental' FROM rental
--     UNION ALL
--     SELECT last_update, 'film' FROM film
--     UNION ALL
--     SELECT last_update, 'actor' FROM actor
--     UNION ALL
--     SELECT last_update, 'inventory' FROM inventory
-- ) AS updates
-- GROUP BY last_update, table_name
-- ORDER BY last_update DESC
-- LIMIT 5;

SELECT
    CASE
        WHEN ABS(TIMESTAMPDIFF(HOUR, '2006-02-23 05:00:00', MAX(last_update))) > 24 THEN CONCAT_WS(',', DAYNAME(MAX(last_update)), DATE_FORMAT(MAX(last_update), '%d %M %Y'))
        WHEN ABS(TIMESTAMPDIFF(SECOND, '2006-02-23 05:00:00', MAX(last_update))) > 60 THEN CONCAT_WS(',', DAYNAME(MAX(last_update)), DATE_FORMAT(MAX(last_update), '%d %M %Y'))
        WHEN ABS(TIMESTAMPDIFF(MINUTE, '2006-02-23 05:00:00', MAX(last_update))) > 60 THEN CONCAT_WS(',', DAYNAME(MAX(last_update)), DATE_FORMAT(MAX(last_update), '%d %M %Y'))
        ELSE CONCAT('Terakhir diupdate ', DATE_FORMAT(MAX(last_update), '%W, %d %M %Y'))
    END AS last_update,
    CASE
        WHEN table_name = 'store' THEN 'Perubahan Data Store'
        WHEN table_name = 'payment' THEN 'Perubahan Data Payment'
        WHEN table_name = 'rental' THEN 'Perubahan Data Rental'
        WHEN table_name = 'film' THEN 'Perubahan Data Film'
        WHEN table_name = 'actor' THEN 'Perubahan Data Actor'
        WHEN table_name = 'inventory' THEN 'Perubahan Data Inventory'
        ELSE 'Perubahan Data Lainnya'
    END AS action
FROM (
    SELECT last_update, 'store' AS table_name FROM store
    UNION ALL
    SELECT last_update, 'payment' FROM payment
    UNION ALL
    SELECT last_update, 'rental' FROM rental
    UNION ALL
    SELECT last_update, 'film' FROM film
    UNION ALL
    SELECT last_update, 'actor' FROM actor
    UNION ALL
    SELECT last_update, 'inventory' FROM inventory
) AS updates
GROUP BY table_name
ORDER BY MAX(last_update) DESC
LIMIT 5;
-- Kalau tidak digrup by 1ji outputna kak 

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


