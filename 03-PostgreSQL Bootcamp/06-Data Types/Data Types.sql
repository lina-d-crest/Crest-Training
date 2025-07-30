--1. Sample table

create table table_boolean(
	product_id serial primary key,
	is_available boolean not null
);

--2. Insert data in table_boolean

insert into table_boolean(is_available) 
values ('true'),('false'),('true'),('false'),('yes'),('1')

insert into table_boolean(is_available) values ('n') --false

--3. View Record

select * from table_boolean

--4. Insertmore variable of boolean data

select *
from table_boolean
where is_available = 'true'

--5. condition search

select *
from table_boolean
where is_available = 'y'

--Not for condition

select *
from table_boolean
where not is_available

--6. Set default values for boolean colunms

alter table table_boolean
alter column is_available
set default false

insert into table_boolean(product_id) values ('13')


select cast ('Adnan' as character (10)) as "Name"

select 'Adnan'::char(10) as "Name"

