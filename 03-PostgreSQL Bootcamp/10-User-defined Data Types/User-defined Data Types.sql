--1. create domain name as data_type constraint
-- Example - 1

create domain addr varchar(100) not null

create table locations (
	address addr
);
 
insert into locations (address) values ('123 London123 London123 London123 London123 London123 London123')

select * from locations

--Example - 2

create domain positive_numeric int not null check(value>0)

create table sample(
	sample_id serial primary key,
	value_num positive_numeric
);

insert into sample (value_num) values (-10)

select * from sample

--Example - 3

create domain us_postal_code  as text check (value~'^\d(5)$' or value~'^\D[{5}-\d{4}$')

create table addresses(
	addresses_id serial primary key,
	postal_code us_postal_code
);

insert into addresses (postal_code) values ('10000')

select * from addresses

--Example - 4

create domain proper_email_check  varchar(150) check (value ~* '^[A-Za-z0-9._%-]+[.][A-Za-z]+$')

create table client_name(
	client_name_id serial primary key,
	email proper_email_check
);

insert into client_name (email) values ('a@b.com')

select * from client_name

--Example - 5

create domain valid_colour varchar(10) check (value in ('red','green','blue'))

create table colour(
	colour valid_colour
);

insert into colour (colour) values ('red')

select * from colour

--Example - 6

create domain user_status varchar(10) check (value in ('enable','disable','temp'))

create table user_check(
	status user_status
);

insert into user_check (status) values ('enable')

select * from user_check

--2. Get all domain in schema

select typname
from pg_catalog.pg_type
join pg_catalog.pg_namespace
on pg_namespace.oid = pg_type.typnamespace
where typtype = 'd' and nspname = 'public'

drop domain positive_numeric cascade

select * from sample

drop domain valid_colour cascade

select * from colour

--Example - 7 create a composite 'inventory_item' data type

create type inventory_item as (
	product_name varchar(200),
	supplier_id int,
	price numeric
)

create table inventory(
	inventory_id serial primary key,
	item inventory_item
);

insert into inventory (item) values (row('paper',20,4.99))

select * from inventory

select (item).product_name from inventory where (item).price < 5.99

--Example - 8 create a currency enum data type with currency data

create type currency as enum ('USD','EUR','GBP')

select 'USD' :: currency

alter type currency add value 'CHF' after 'EUR'

create table stocks(
	stock_id serial primary key,
	stock_currency currency
);

insert into stocks (stock_currency) values ('USD')

select * from stocks

--Example - 9 drop type

create type sample_type as enum ('ABC','123')

drop type sample_type

create type myaddress as(
	city varchar(50),
	country varchar(20)
)

alter type myaddress rename to my_address
alter type my_address owner to postgres
alter type my_address set schema test_scm
alter type my_address add attribute street_address varchar(150)

--Example - 10

create type mycolours as enum ('green','red','blue')
alter type mycolours rename value 'red' to 'black'
select enum_range(null::mycolours)
alter type mycolours add value 'red' before 'green'
alter type mycolours add value 'yellow' after 'green'

--Example - 11

create type status_enum as enum ('queued','waiting','running','done')

create table jobs(
	job_id serial primary key,
	job_status status_enum
);

insert into jobs (job_status) values ('done')
select * from jobs

update jobs set job_status = 'running' where job_status = 'waiting'

alter type status_enum rename to status_enum_old

create type status_enum as enum ('queued','running','done')

alter table jobs alter column job_status type status_enum using job_status::text::status_enum

drop type status_enum_old

--Example - 12

create type status as enum ('pending','approved','declined')

create table cron_jobs(
	cron_jobs_id int,
	status status default 'pending'
);

insert into cron_jobs (cron_jobs_id,status) values (2,'approved')

select * from cron_jobs

--Example - 13

do 
$$
begin 
	if not exists (select *
							from pg_type typ
								inner join pg_namespace nsp
											on nsp.oid = typ.typnamespace
							where nsp.nspname = current_schema()
									and typ.typname = 'a') then
		create type ai
					as (a text,
						i integer);
	end if;
end;
$$
language plpgsql;