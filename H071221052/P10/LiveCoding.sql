USE sakila;

-- Nomor 1 --
select * from film;

SELECT title, DESCRIPTION, rating , rental_rate
FROM film
WHERE rating = 'G' AND language_id = 1 AND rental_rate <= 1
ORDER BY title ASC;

-- Nomor 2 --
select * from rental;
select * from customer;
select * from payment;

select concat(c.first_name, ' ', c.last_name) as nama_customer, 
count(r.rental_id) as jumlah_rental,
CONCAT_WS(' ', DAYNAME(r.rental_date),DAY(r.rental_date), MONTHNAME(r.rental_date), YEAR(r.rental_date)) AS 'tanggal_pinjam',
sum(p.amount) as 'total_pembayaran'
  from customer c
  join rental r
  using(customer_id)
  join payment p
  using(rental_id)
  where r.rental_date like '%07-07%'
  group by nama_customer
  order by jumlah_rental desc
  limit 1;
  
  -- Nomor 3 -- 
  select * from actor;
  select * from language;
  select * from film;
  select * from category;
  select * from film_category;
  
  select concat(first_name, ' ', last_name) as 'nama aktor', 
  film.title as 'judul film', category.name as 'kategori',
  case
  when film.length > 150 then 'panjang'
  when film.length < 70 then 'pendek'
  else 'sedang'
  end as 'durasi film' from actor 
  JOIN film_actor 
USING(actor_id)
JOIN film 
USING(film_id)
JOIN film_category 
USING(film_id)
JOIN category 
USING(category_id)
WHERE category.category_id IN (SELECT category.category_id
FROM category 
WHERE category.name = "Sci-Fi"
UNION
SELECT category.category_id
FROM category
WHERE category.name = "Drama")
GROUP BY film.title;