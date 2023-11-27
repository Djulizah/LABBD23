# Nama : Sakinah NuruSyifa
# NIM : H071221049

# NO 1 - Iswari
select 
	title,
    rating,
    rental_rate
from film
where rating = 'R' and `description` not like '%boring%' and title like '%O'
order by title
limit 5;
	

# NO 2 - Alqa
select 
	concat(actor.first_name, ' ', actor.last_name) as 'Nama aktor',
    count(film.film_id) as 'Jumlah film',
    film.title as 'judul film',
    film.rating,
    film.rental_duration 
from film
join film_actor using (film_id)
join actor using (actor_id)
group by concat(actor.first_name, ' ', actor.last_name)
having count(film.film_id) > 3 and film.rating = 'G' and film.rental_duration > 3
order by count(film.film_id)
limit 15;


# NO 3 - Dilah

select 
	concat(customer.first_name, " ", customer.last_name) as 'nama_pelanggan', 
    country.`country` as 'negara_asal',
	sum(payment.amount) as 'total_pembayaran',
	case
	when sum(payment.amount) > (select avg(`total`) from (
		select sum(payment.amount) as 'total'
		from payment 
		join customer 
        using (customer_id)) as a
		) then 'pelanggan sejahtera'
	when sum(payment.amount) < (select avg(`total`) from (
		select sum(payment.amount) as 'total'
		from payment 
		join customer 
        using(customer_id)) as a
		) then 'pelanggan yang sudah berusaha'
	end
	as 'kategori_pelanggan'
from customer 
join payment using(customer_id)
join address using(address_id)
join city using(city_id)
join country using(country_id)
where country.`country` = 'united states'
group by nama_pelanggan
    
union

select 
	concat(customer.first_name, " ", customer.last_name) as 'nama_pelanggan', 
    country.`country` as 'negara_asal',
	sum(payment.amount) as 'total_pembayaran',
	case
	when sum(payment.amount) > (select avg(`total`) from (
		select sum(payment.amount) as 'total'
		from payment 
		join customer 
        using (customer_id)) as a
		) then 'pelanggan sejahtera'
	when sum(payment.amount) < (select avg(`total`) from (
		select sum(payment.amount) as 'total'
		from payment 
		join customer 
        using(customer_id)) as a
		) then 'pelanggan yang sudah berusaha'
	end
	as 'kategori_pelanggan'
from customer 
join payment using(customer_id)
join address using(address_id)
join city using(city_id)
join country using(country_id)
where country.`country` = 'united kingdom'
group by nama_pelanggan;




    
select * from country