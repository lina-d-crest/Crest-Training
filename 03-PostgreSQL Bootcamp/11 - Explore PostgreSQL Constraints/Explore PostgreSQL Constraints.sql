	--NULL Constraint
--1. create sample table

create table table_nn(
	id serial primary key,
	tag text not null
);

--2. Insert data into table 

insert into table_nn (tag) values ('Adam')
insert into table_nn (tag) values ('')
insert into table_nn (tag) values ('0')

--3. View table

select * from table_nn

--4. create sample table

create table table_nn2(
	id serial primary key,
	tag2 text not null
);

alter table table_nn2
alter column tag2 set not null

--5. Insert data into table 

insert into table_nn2 (tag2) values ('Adam')
insert into table_nn2 (tag2) values (null)
insert into table_nn2 (tag2) values ('')

--UNIQUE Constraint
--6. create sample table

create table table_emails(
	id serial primary key,
	email text unique
);

--7. Insert data into table 

insert into table_emails (email) values ('a@b.com')

--8. View table

select * from table_emails

--9. create sample table

create table table_products(
	id serial primary key,
	product_code varchar(10),
	product_name text
);

alter table table_products
add constraint unique_product_code unique (product_code,product_name)

--10. Insert data into table 

insert into table_products (product_code,product_name) values ('apple','A')

--11. View table

select * from table_products

--DEFAULT Constraint
--12. create sample table

create table employees(
	employee_id serial primary key,
	first_name varchar(50),
	last_name varchar(50),
	is_enable varchar(2) default 'Y'
);

--10. Insert data into table 

insert into employees (first_name,last_name) values ('John','Adam')
insert into employees (first_name,last_name,is_enable) values ('Adam','John','N')

--11. View table

select * from employees
