#LIVE CODING
USE sakila
SELECT * FROM film

#SYF1
SELECT title,release_year AS Tahun_Rilis,`length` AS Durasi
FROM film
WHERE `length` BETWEEN 180 AND 200
#SYF1

#SYF2
SELECT f.title,COUNT(p.payment_id),SUM(p.amount)
FROM film AS f
JOIN inventory AS i
USING (film_id)
JOIN rental AS r
USING (inventory_id)
JOIN payment AS p
USING (rental_id)
JOIN film_category AS fc
USING (film_id)
JOIN category AS c
USING (category_id)
WHERE c.`name`= 'Animation'
GROUP BY f.title
#SYF2

#AL3
(SELECT CONCAT(cu.first_name,' ',cu.last_name) AS Nama_pelanggan,f.title AS Judul_film,COUNT(r.rental_id) AS jumlah_peminjaman,
case
	when COUNT(r.rental_id)>1 then 'Sering Pinjam'
	ELSE 'Kadang Pinjam'
	END AS rental_status
FROM customer AS cu
JOIN rental AS r
USING (customer_id)
JOIN inventory AS i
USING (inventory_id)
JOIN film AS f
USING (film_id)
GROUP BY cu.customer_id,f.film_id
ORDER BY Jumlah_Peminjaman ASC
LIMIT 10)
UNION
(SELECT CONCAT(cu.first_name,' ',cu.last_name) AS Nama_pelanggan,f.title AS Judul_film,COUNT(r.rental_id) AS jumlah_peminjaman,
case
	when COUNT(r.rental_id)>1 then 'Sering Pinjam'
	ELSE 'Kadang Pinjam'
	END AS rental_status
FROM customer AS cu
JOIN rental AS r
USING (customer_id)
JOIN inventory AS i
USING (inventory_id)
JOIN film AS f
USING (film_id)
GROUP BY cu.customer_id,f.film_id
ORDER BY Jumlah_Peminjaman desc
LIMIT 10)

