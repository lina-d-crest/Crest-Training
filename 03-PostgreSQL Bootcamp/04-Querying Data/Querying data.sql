select * from movies;

select * from actors;

select first_name from actors;
select first_name,last_name from actors;

select movie_name,movie_lang from movies;

select first_name as FirstName from actors;
select first_name as "First Name" from actors;

-- Give alias 

select 
	movie_name as "Movie Name",
	movie_lang as "Language" 
from movies;

select first_name || last_name from actors;
select first_name ||' ' || last_name from actors;

select 
	first_name ||' ' || last_name as "Full Name"
from actors;

-- Display mathematical operation 

select 2*10 as "Num"

-- Display in order

select *
from movies
order by 	
	release_date desc,
	movie_name asc	
	
select *
from movies
order by
	movie_name asc,
	release_date desc

select
	first_name,
	last_name as "Surname"
from actors
order by last_name desc

select
	first_name,
	length(first_name)	
from actors

select
	first_name,
	length(first_name) as len	
from actors
order by 
	len desc

select *
from actors 
order by
	first_name asc,
	date_of_birth desc

select
	first_name,
	last_name,
	date_of_birth
from actors
order by
	first_name asc,
	date_of_birth desc

select
	first_name,
	last_name,
	date_of_birth
from actors
order by
	1 asc,
	3 desc

-- Create Customer demo

create table demo(
	num int	
);

--Insert values in demo Table

insert into  demo(num) values (1),(2),(3)
insert into  demo(num) values (null)

select * 
from demo 
order by
	num asc
	
select * 
from demo 
order by
	num nulls last

select * 
from demo 
order by
	num nulls first

drop table demo

select
	movie_lang
from movies	

select
	distinct movie_lang
from movies	