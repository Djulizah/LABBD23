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
    COUNT(rental.rental_id) AS 'Staff Total Customer Count',
    SUM(payment.amount * 0.8) AS 'Staff Income'
FROM
    staff
JOIN
    payment ON staff.staff_id = payment.staff_id
JOIN
    rental ON payment.rental_id = rental.rental_id
GROUP BY
    staff.staff_id
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
SELECT
    CASE
        WHEN TIMESTAMPDIFF(SECOND, MAX(last_update), NOW()) < 60 THEN CONCAT('Terakhir diupdate ', TIMESTAMPDIFF(SECOND, MAX(last_update), NOW()), ' detik lalu')
        WHEN TIMESTAMPDIFF(MINUTE, MAX(last_update), NOW()) < 60 THEN CONCAT('Terakhir diupdate ', TIMESTAMPDIFF(MINUTE, MAX(last_update), NOW()), ' menit lalu')
        WHEN TIMESTAMPDIFF(HOUR, MAX(last_update), NOW()) < 24 THEN CONCAT('Terakhir diupdate ', TIMESTAMPDIFF(HOUR, MAX(last_update), NOW()), ' jam lalu')
        ELSE CONCAT('Terakhir diupdate ', DATE_FORMAT(MAX(last_update), '%W, %d %M %Y'))
    END AS last_update,
    CONCAT('Perubahan pada data ', table_name) AS action
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
GROUP BY last_update, table_name
ORDER BY last_update DESC
LIMIT 5;
