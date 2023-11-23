USE sakila ; 

-- 1 
SELECT title, `length`, rating
FROM film 
WHERE `length` < 90 AND rating = 'G'

-- 2 
SELECT distinct CONCAT (cust.first_name, ' ', cust.last_name) AS 'Nama Pelanggan' , fi.title AS 'Judul', ci.city AS 'Kota', ctry.country AS 'Negara'
FROM customer cust
JOIN address ad ON cust.address_id = ad.address_id 
JOIN city ci ON ad.city_id = ci.city_id
JOIN country ctry ON ci.country_id = ctry.country_id
JOIN store st ON cust.store_id = st.store_id
JOIN inventory invt ON st.store_id = invt.store_id
JOIN film fi ON invt.film_id = fi.film_id 
WHERE fi.title = 'dracula crystal' AND ctry.country = 'Indonesia'
ORDER BY 'Nama Pelanggan' ; 

-- 3 
SELECT fi.film_id AS 'id_film/id_actor', fi.title AS 'judul film/nama aktor', 
case 
when fi.description LIKE '%robot%' AND fi.`length` > 
		(SELECT AVG(durasi) FROM (SELECT SUM(fi.`length`) AS 'durasi'
		FROM film fi GROUP BY fi.film_id) AS a)
AND a.first_name LIKE 'u%' AND a.last_name LIKE 'w%' then 'film pilihan Andika'
when fi.rating = 'G'
AND fi.`length` < 
		(SELECT AVG(durasi) FROM (SELECT SUM(fi.`length`) AS 'durasi'
		FROM film fi GROUP BY fi.film_id) AS a)
AND fi.description LIKE '%Manhattan%'
AND a.first_name = 'MATTHEW' then 'film pilihan Dendi'
END AS keterangan
FROM film fi
JOIN film_actor fa ON fi.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
HAVING keterangan 

UNION 

SELECT fi.film_id AS 'id_film/id_actor', fi.title AS 'judul film/nama aktor', 
case 
when  fi.`length` > 
		(SELECT AVG(durasi) FROM (SELECT SUM(fi.`length`) AS 'durasi'
		FROM film fi GROUP BY fi.film_id) AS a)
AND a.first_name LIKE 'u%' AND a.last_name LIKE 'w%' then 'aktor pilihan Andika'
when fi.rating = 'G'
AND fi.`length` < 
		(SELECT AVG(durasi) FROM (SELECT SUM(fi.`length`) AS 'durasi'
		FROM film fi GROUP BY fi.film_id) AS a)
AND a.first_name = 'MATTHEW' then 'aktor pilihan Dendi'
END AS keterangan
FROM film fi
JOIN film_actor fa ON fi.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
HAVING keterangan 
--- KAKK SUSAH SEKALI SOALNYA ISWARII YANG INI KAKKKKK -----------


 
