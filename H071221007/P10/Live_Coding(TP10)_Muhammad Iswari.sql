-- Nama	: Muhammad Iswari
-- NIM 	: H071221007
-- Kelompok 10



-- No 1 (Wali)
SELECT GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') 'Nama Actor' , f.title 'Judul Film' FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE LENGTH(f.title) % 2 = 0 AND c.name = 'Horror'
GROUP BY f.film_id;


-- No 2 (Iqbal)
SELECT f.title, c.name category_name, f.release_year, f.description short_description,
GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') actors FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE c.name = 'comedy'
GROUP BY f.film_id;


-- No 3 (Syifa)
-- Cara 1 (tanpa subquery dan union)
SELECT f.title 'Judul Film', c.name Kategori,
f.rating 'Kode Rating', 
case 
when f.rating = 'G' then 'Semua umur'
when f.rating = 'PG' then 'Dengan pengawasan orang tua'
END AS Keterangan
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'action' AND (f.rating = 'G' OR f.rating = 'PG');

-- Cara 2 (dengan subquery dan union)
SELECT f.title 'Judul Film', c.name Kategori,
f.rating 'Kode Rating', 
case 
when f.rating = 'G' then 'Semua umur'
when f.rating = 'PG' then 'Dengan pengawasan orang tua'
END AS Keterangan
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'action' AND f.film_id IN 
	(SELECT f.film_id FROM film f
	JOIN film_category fc ON f.film_id = fc.film_id
	JOIN category c ON c.category_id = fc.category_id 
	WHERE c.name = 'action' AND f.rating = 'G'
	
	UNION 
	
	SELECT f.film_id FROM film f
	JOIN film_category fc ON f.film_id = fc.film_id
	JOIN category c ON c.category_id = fc.category_id 
	WHERE c.name = 'action' AND f.rating = 'PG');