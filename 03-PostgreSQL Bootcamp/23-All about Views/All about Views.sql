--1. Create view to include all movies with directors first and last name

create or replace view v_movie_quick as
select movie_name,movie_length,release_date
from movies mv;

select *
from movies mv
inner join directors d on d.director_id = mv.director_id;

--2. Rename a view

alter view v_movie_quick rename to v_movie_quick2;
select * from v_movie_quick2;

--3. Delete a view

drop view v_movie_quick2;

--4. Create a view to list all movies release after 1997.

create or replace view v_movie_after_1997 as
select * 
from movies
where release_date >= '1997-12-31'
order by release_date asc;

--5. Select all movies with english language only from the view

select * 
from v_movie_after_1997
where movie_lang = 'English'
order by movie_lang;

--6. Select all movies with english language and age certificate 12 only from the view

select * 
from v_movie_after_1997
where movie_lang = 'English' and age_certificate = '12'
order by movie_lang;

--7. Select all movies with directors with american and japanese nationality

select *
from movies mv
inner join directors d on d.director_id = mv.director_id
where nationality in ('American','Japanese')
order by nationality;

--8. Lets have a view for all peoples in a movies like actors and directors with first, last names
 
create view v_all_actors_directors as
select 
	first_name,
	last_name,
	'actors' as people_type
from actors 
union all 
select
	first_name,
	last_name,
	'directors' as people_type
from directors;

select *
from v_all_actors_directors
where first_name = 'John'
order by people_type, first_name;
 
-- Connecting multiple table with a single view
--9. Lets connect movies, directors, movies revenues tables with a single view
 
select *
from movies mv
inner join directors d on d.director_id = mv.director_id
inner join movies_revenues r on r.movie_id = mv.movie_id;

--10. The above query contains multiple same column like movie_id, can we use CREATE VIEW?
 
create view v_movies_directors_revenues as
select
	mv.movie_id,
	mv.movie_name,
	mv.movie_length,
	mv.movie_lang,
	mv.age_certificate,
	mv.release_date,
	d.director_id,
	d.first_name,
	d.last_name,
	d.nationality,
	d.date_of_birth,
	r.revenue_id,
	r.revenues_domestic,
	r.revenues_international
from movies mv
inner join directors d on d.director_id = mv.director_id
inner join movies_revenues r on r.movie_id = mv.movie_id;
 
--11. Without views

select
	mv.movie_id,
	mv.movie_name,
	mv.movie_length,
	mv.movie_lang,
	mv.age_certificate,
	mv.release_date,
	d.director_id,
	d.first_name,
	d.last_name,
	d.nationality,
	d.date_of_birth,
	r.revenue_id,
	r.revenues_domestic,
	r.revenues_international
from movies mv
inner join directors d on d.director_id = mv.director_id
inner join movies_revenues r on r.movie_id = mv.movie_id
where age_certificate = '12';
 
--12. With views

select *
from v_movies_directors_revenues 
where age_certificate = '12';
 
-- Changing views
--13. Can I re-arrange a cloumn to an existing view?
 
create view v_directors as
select first_name,last_name
from directors;
 
select * from v_directors;
 
--14. Can I remove a column from an existing view?
 
create view v_directors as
select first_name
from directors;
 
--15. Can i add a column to an existing view?
 
create or replace view v_directors as
select first_name,last_name,nationality
from directors;
 
--16. A regular view;

select * from v_directors;
insert into directors (first_name) values ('test name1');
 
select * from directors;
delete from directors where director_id = 39;

--17. Create an updatable view for directors table

create or replace view vu_directors as
select first_name,last_name
from directors;

--18. Add some records via a view and not from underlying table

insert into vu_directors (first_name) values ('dir1'),('dir2');

--19. Ckeck the contents of directors table via view

select * from vu_directors;

--20. Delete somr records via  a view and not from underlying table

delete from vu_directors where first_name = 'dir1';

--21. Create a table for countries

create table countries(
	country_id serial primary key,
	country_code varchar(4),
	city_name varchar(100)
);

--22. Insert sample data into table

insert into countries (country_code,city_name) values 
('US','New York'),
('US','New Jersey'),
('UK','London');

select * from countries;

--23. Create a sample view called v_cities_us to list all us based cities

create or replace view v_cities_us as
select country_id,country_code,city_name
from countries
where country_code = 'US';

--24. View the content of v_cities_us

select * from v_cities_us;

--25. Inseret US based data

insert into v_cities_us (country_code,city_name) values 
('US','California');

--26. Update view v_cities_us using with check option

create or replace view v_cities_us as
select country_id,country_code,city_name
from countries
where country_code = 'US'
with check option;

insert into v_cities_us (country_code,city_name) values 
('UK','Leeds');

--27. Lets try the update operations on view having with check option, can we add the data
 
select * from v_cities_us;
 
update v_cities_us
set country_code = 'uk'
where city_name = 'new york';
 
insert into v_cities_us (country_code, city_name) values ('us', 'chicago');

update v_cities_us
set country_code = 'uk';
 
--28. Using local and cascaded in with check option
 
create or replace view v_cities_c as
select country_id,country_code,city_name
from countries
where city_name like 'c%';
 
select * from v_cities_c;
 
create or replace view v_cities_c_us as
select country_id,country_code,city_name
from countries
where city_name like 'c%' and country_code = 'us'
with local check option;

insert into v_cities_c_us (country_code, city_name) values('us', 'connecticut');

select * from v_cities_c_us;

insert into v_cities_c_us (country_code, city_name)values ('us', 'los anglese');

select * from v_cities_c_us;
 
select * from countries;
 
--29. create a materialized view
 
create materialized view if not exists mv_directors as
select first_name,last_name
from directors
with data;
 
select * from mv_directors;

create materialized view if not exists mv_directors_nodata as
select first_name,last_name
from directors
with no data;
 
select * from mv_directors_nodata;
 
refresh materialized view mv_directors_nodata;
 
--30. Drop a materializrd view
 
drop materialized view mv_directors;
 
--31. Changing material view data
 
select * from mv_directors;
 
insert into mv_directors (first_name) values ('dir1'), ('dir2');

refresh materialized view mv_directors;
 
delete from mv_directors where first_time = 'dir1';

 