/* 1a*/
select first_name, last_name from actor;
/* 1b*/
select Concat(Upper(first_name),' ',Upper(last_name)) as Actor_Name from actor;
/* 2a*/
select * from actor where first_name='Joe';
/* 2b*/
select * from actor where last_name like '%gen%';
/* 2c*/
select last_name , first_name from actor where last_name like '%li%';
/* 2d*/
select country_id,country from country where country in ('Afghanistan', 'Bangladesh', 'China');
/* 3a*/
alter table actor
add middle_name varchar(100) after `first_name`;
/*3b*/
alter table actor
change middle_name middle_name blob;
/*3c*/
alter table actor
drop middle_name
/*4a*/
select last_name,count(last_name) from actor group by last_name
/*4b*/
select last_name, count(last_name) 
from actor 
group by last_name
having count(last_name)>1
/*4c*/
update actor
set first_name ='HARPO'
where first_name ='Groucho' and last_name='williams'
/*4d*/

update actor
set first_name ='GROUCHO'
where actor_id=72
/*5a*/
show create table address
/*if does not give a result, you're in wrong schema*/
show schemas 
/*6a*/
select a.first_name, a.last_name, b.address from staff as a
join address as b on a.address_id=b.address_id
/*6b*/
select b.first_name, b.last_name, sum(a.amount) as total_amount from payment as a
join staff as b on a.staff_id=b.staff_id
where payment_date>'2005-08-01' and payment_date<'2005-09-01'
group by a.staff_id
/*6c*/
select b.title,count(a.actor_id) as num_of_actors from film_actor as a
inner join film as b on a.film_id=b.film_id
group by a.film_id
/*6d*/
select b.title, count(a.film_id) as num_of_copies from inventory as a
inner join film as b on a.film_id=b.film_id
where b.title='Hunchback Impossible'
group by a.film_id
/*6e*/
select a.last_name, a.first_name, count(b.amount) from customer as a
join payment as b on a.customer_id=b.customer_id
group by a.customer_id
order by a.last_name asc;
/*7a without subqueries
select a.title, b.name from film as a
join language as b on a.language_id=b.language_id
where (a.title like 'k%' or a.title like 'q%') and b.name='English';
/*7a*/
select title from film 
where language_id in 
(select language_id from language where name='English')
and (title like 'k%' or title like 'q%');
/*7b*/
select first_name, last_name from actor where actor_id in
(select actor_id from film_actor where film_id in
(select film_id from film where title='Alone Trip'));
/*7c*/
select first_name, last_name, email from customer as a
join address as b on a.address_id= b.address_id
join city as c on b.city_id=c.city_id
join country as d on c.country_id=d.country_id
where d.country='Canada';
/*7d*/
select title from film as a
join film_category as b on a.film_id=b.film_id
join category as c on b.category_id=c.category_id
where c.name='Family'
/*7e*/
select title, count(title) as num_rental from film as a
join inventory as b on a.film_id=b.film_id
join rental as c on b.inventory_id=c.inventory_id
group by a.title
order by count(title) desc
/*7f*/
select b.store_id, sum(amount) from payment as a
join staff as b on a.staff_id=b.staff_id
join store as c on b.store_id=c.store_id
group by c.store_id
/*7g*/
select a.store_id, c.city, d.country from store as a
join address as b on a.address_id=b.address_id
join city as c on b.city_id=c.city_id
join country as d on c.country_id=d.country_id
/*7h*/
select a.name,sum(e.amount) as gross_revenue from category as a
join film_category as b on a.category_id=b.category_id
join inventory as c on b.film_id=c.film_id
join rental as d on c.inventory_id=d.inventory_id
join payment as e on d.rental_id=e.rental_id
group by a.name
order by gross_revenue desc
limit 5
/*8a*/
create view top_five_genres as 
select a.name,sum(e.amount) as gross_revenue from category as a
join film_category as b on a.category_id=b.category_id
join inventory as c on b.film_id=c.film_id
join rental as d on c.inventory_id=d.inventory_id
join payment as e on d.rental_id=e.rental_id
group by a.name
order by gross_revenue desc
limit 5
/*8b*/
select * from top_five_genres
/*8c*/
drop view top_five_genres