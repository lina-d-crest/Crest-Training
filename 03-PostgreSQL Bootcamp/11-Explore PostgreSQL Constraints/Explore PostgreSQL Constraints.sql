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

--13. Insert data into table 

insert into employees (first_name,last_name) values ('John','Adam')
insert into employees (first_name,last_name,is_enable) values ('Adam','John','N')

--14. View table

select * from employees

--15.  create sample table

create table table_items(
	item_id serial primary key,
	item_name varchar(100) not null
);

--16. Insert data into table 

insert into table_items (item_id,item_name) values (1,'Pen'),(2,'Pen')

--17. View table

select * from table_items

--18. Drop a constraint

alter table table_items
drop constraint table_items_pkey

--19. Alter table and add a primary key

alter table table_items
add primary key(item_id)

--20. create sample table

create table t_grades(
	course_id varchar(100) not null,
	student_id varchar(100) not null,
	grade int not null
);

--21. Insert data into table 

insert into t_grades (course_id,student_id,grade) values ('Math','S2',70),('Chemistry','S1',70),('English','S2',70),('Physics','S1',80)

--22. View table

select * from t_grades

--23. Drop a constraint

alter table t_grades
drop constraint t_grades_pkey

--24. Add Constraint

alter table t_grades
add constraint t_grades_course_id_session_id_pkey
primary key (course_id,student_id)

--Without Foreign key Conatraint
--25.  create sample table

create table t_products(
	product_id serial primary key,
	product_name varchar(100) not null,
	supplier_id int not null
);

create table t_suppliers(
	supplier_id serial primary key,
	supplier_name varchar(100) not null
);

--26. Insert data into table 

insert into t_suppliers (supplier_id,supplier_name) values (1,'Supplier1'),(2,'Supplier1')

--27. View table

select * from t_suppliers

--28. Insert data into table 

insert into t_products (product_id,product_name,supplier_id) values (1,'Pen',1),(2,'Paper',2),(3,'Computer',3)

--29. View table

select * from t_suppliers

--With Foreign key Conatraint

drop table t_products
drop table t_suppliers

--30. create sample table

create table t_products(
	product_id serial primary key,
	product_name varchar(100) not null,
	supplier_id int not null,
	foreign key (supplier_id) references t_suppliers (supplier_id)
);

create table t_suppliers(
	supplier_id serial primary key,
	supplier_name varchar(100) not null
);

--31. Insert data into table 

insert into t_suppliers (supplier_id,supplier_name) values (1,'Supplier1'),(2,'Supplier2')

--32. View table

select * from t_suppliers

--33. Insert data into table 

insert into t_products (product_id,product_name,supplier_id) values (1,'Pen',1),(2,'Paper',2)

--34. View table

select * from t_products

update t_products
set supplier_id = 2
where product_id = 1 

--35. Drop constraint

alter table t_products
drop constraint t_products_supplier_id_fkey

--36. Add or update foreign key constraint 

alter table t_products
add constraint t_products_supplier_id_fkey foreign key (supplier_id) references t_suppliers (supplier_id)	

--37. create sample table

create table staff(
	staff_id serial primary key,
	first_name varchar(50),
	last_name varchar(50),
	birth_date date check (birth_date > '1990-01-01'),
	joined_date date check (joined_date > birth_date),
	salary numeric check (salary>0)
)

--38. Insert data into table 

insert into staff (first_name,last_name,birth_date,joined_date,salary) values ('Adam','king','1990-01-02','2002-01-01',100)
insert into staff (first_name,last_name,birth_date,joined_date,salary) values ('John','Adams','2020-01-01','2020-01-02',100)

--39. View table

select * from staff

update staff
set salary = 1000
where staff_id = 2 

--40. create sample table

create table prices(
	price_id serial primary key,
	product_id int not null,
	price numeric not null,
	discount numeric not null,
	valid_from date not null
)

alter table prices
add constraint 	price_check
check (price >0 and discount >=0 and price > discount)

--41. Insert data into table 

insert into prices (product_id,price,discount,valid_from) values ('2',100,20,'2020-10-01')

--42. View table

select * from prices

--43. Rename Constraint 

alter table prices
rename constraint price_check to price_discount_check