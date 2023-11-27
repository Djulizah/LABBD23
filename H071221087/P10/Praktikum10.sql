#Muhammad iqbal_H071221087

-- Nomor 1
SELECT title AS "JudulFilm", release_year AS "TahunRilis", Rating, rental_duration AS "DurasiSewa", rental_rate AS "HargaRental"
FROM film
WHERE rating = 'G' AND rental_duration > 5 AND rental_rate < 4
ORDER BY rental_duration DESC
limit 20;


-- Nomor 2 
SELECT customer_id, CONCAT(first_name, ' ', last_name) AS 'nama lengkap', address, city, country, COUNT(customer_id) AS 'total film pernah dirental'
FROM country JOIN city USING(country_id)
JOIN address USING(city_id)
JOIN customer USING (address_id)
JOIN rental USING (customer_id)
WHERE ACTIVE = 0 AND store_id = 1
GROUP BY customer_id;


-- Nomor 3
(SELECT DISTINCT film.title AS judul_film, category_name AS genre_film, case 
when film.rating > (SELECT AVG(rating) FROM film) then 'best film' 
END AS reting_film 
FROM film 
JOIN film_category
USING (film_id)
JOIN category 
USING (category_id)
HAVING rating_film IS NOT NULL 
LIMIT 50)
UNION 


