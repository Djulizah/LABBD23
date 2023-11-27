#final 1
# g = semua umur, pg = bo, pg13 = bo < 13th, r = restricted <17th (13-16), nc = >17


# iqb, wali, dwn

-- no1 iqb1
SELECT f.title AS 'judulFilm', f.rating AS 'ratingFilm', GROUP_CONCAT(CONCAT(a.first_name, " ", a.last_name) SEPARATOR ', ') AS 'actors'
FROM film f
JOIN film_actor USING(film_id)
JOIN actor a USING(actor_id)
WHERE f.title LIKE 'w%' 
GROUP BY f.title

-- no2 wali2
SELECT f.title, SUM(p.amount) AS 'total_payment'
FROM film f
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
JOIN payment p USING(rental_id)
WHERE f.rating = 'r'
GROUP BY f.title
ORDER BY SUM(p.amount) DESC
LIMIT 5


-- no3 dwn3
(SELECT CONCAT(a.first_name, " ", a.last_name) AS 'actor_name',
	COUNT(fa.film_id) AS 'jumlah_film',
	GROUP_CONCAT(f.title SEPARATOR ', ') AS 'judul_film',
	case
	when COUNT(fa.film_id) > 30 then 'Aktor Senior Markotop'
	when COUNT(fa.film_id) <= 30 then 'Aktor Junior Top'
	end
	AS 'status_actor'
FROM actor a
JOIN film_actor fa USING(actor_id)
JOIN film f USING(film_id)
GROUP BY `actor_name`
ORDER BY `jumlah_film` DESC 
LIMIT 3)

UNION 
	
(SELECT CONCAT(a.first_name, " ", a.last_name) AS 'actor_name',
	COUNT(fa.film_id) AS 'jumlah_film',
	GROUP_CONCAT(f.title SEPARATOR ', ') AS 'judul_film',
	case
	when COUNT(fa.film_id) > 30 then 'Aktor Senior Markotop'
	when COUNT(fa.film_id) <= 30 then 'Aktor Junior Top'
	end
	AS 'status_actor'
FROM actor a
JOIN film_actor fa USING(actor_id)
JOIN film f USING(film_id)
GROUP BY `actor_name`
ORDER BY `jumlah_film`	
LIMIT 3)
	
#subquery nya nda ketemu kak
	
	
