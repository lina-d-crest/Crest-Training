--INNER JOIN 
--1. Combime movies and directors tables

select
	movies.movie_id,
	movies.movie_name,
	movies.director_id,
	directors.first_name
from movies
inner join directors
on movies.director_id = directors.director_id;

--2. Combine whole tables

select *
from movies
inner join directors
on movies.director_id = directors.director_id;

--3. with Aliases 

select *
from movies mv
inner join directors dr
on mv.director_id = dr.director_id;

--4. Filter some records

select
	m.movie_id,
	m.movie_name,
	m.movie_lang,
	m.director_id,
	d.first_name
from movies m
inner join directors d
on m.director_id = d.director_id
where movie_lang = 'English';

--5. Use * instead of colunm name

select m.*,d.*
from movies m
inner join directors d
on m.director_id = d.director_id;

--6. Connect two table with using clause

select *
from movies 
inner join directors using (director_id);

--7. Combime movies and movies_revenues tables

select *
from movies m
inner join movies_revenues mr
on m.movie_id = mr.movie_id;

--8. Combime movies,directors and movies_revenues tables

select *
from movies m
inner join movies_revenues mr using (movie_id)
inner join directors d using (director_id);

--9. Select movie name,director name and domestic revenue for all japanese movies

select 
	m.movie_name,
	concat(d.first_name,' ',d.last_name) as director_name,
	mr.revenues_domestic
from movies m
inner join movies_revenues mr using (movie_id)
inner join directors d using (director_id)
where movie_lang = 'Japanese';

--10.  Select movie name,director name for all English,Chinese and Japanese movies where domestic revenue is greater than 100

select 
	m.movie_name,
	m.movie_lang,
	concat(d.first_name,' ',d.last_name) as director_name,
	mr.revenues_domestic
from movies m
inner join movies_revenues mr using (movie_id)
inner join directors d using (director_id)
where movie_lang in ('Japanese','English','Chinese') and revenues_domestic > 100
order by movie_lang;

--11.  Select movie name,director name,movie language ,total revenue for all top 5 movies

select
	m.movie_name,
	m.movie_lang,
	concat(d.first_name,' ',d.last_name) as director_name,
	mr.revenues_domestic,
	mr.revenues_international,
	(mr.revenues_domestic + mr.revenues_international) as "Total_revenue"
from movies m
inner join movies_revenues mr using (movie_id)
inner join directors d using (director_id)
order by revenues_domestic + revenues_international desc nulls last
limit 5;

--12. What were the top 10 most profitable movies between year 2005 to 2008.Print the movie name,director name

select
	m.movie_name,
	concat(d.first_name,' ',d.last_name) as director_name,
	m.release_date,
	mr.revenues_domestic,
	mr.revenues_international,
	(mr.revenues_domestic + mr.revenues_international) as "Total_revenue"
from movies m
inner join movies_revenues mr using (movie_id)
inner join directors d using (director_id)
where release_date between '2005-01-01' and '2008-12-31'
order by revenues_domestic + revenues_international desc nulls last
limit 10;

--13. Create a table with int data type

create table t1 (test int);

--14. Create a table with varchar data type

create table t2 (test varchar(10));

--15. Join table

select *
from t1
inner join t2 on t1.test = t2.test::int; 

--16. Insert sample data into table

insert into t1(test) values (1),(2);
insert into t2(test) values ('aa'),('bb');

select * from t1

--LEFT JOIN
--17. Create sample tables

create table left_product(
	product_id serial primary key,
	product_name varchar(100)
);

create table right_product(
	product_id serial primary key,
	product_name varchar(100)
);

--18. Insert sample data into table

insert into left_product (product_id,product_name) values 
(1,'Computers'),
(2,'Laptops'),
(3,'Monitors'),
(5,'Mics');

insert into right_product (product_id,product_name) values 
(1,'Computers'),
(2,'Laptops'),
(3,'Monitors'),
(4,'Pen'),
(7,'Papers');

--19. View tables

select * from left_product;

select * from right_product;

--20. Join table with left join

select *
from left_product
left join right_product on left_product.product_id = right_product.product_id;
select *
from right_product
left join left_product on left_product.product_id = right_product.product_id;

