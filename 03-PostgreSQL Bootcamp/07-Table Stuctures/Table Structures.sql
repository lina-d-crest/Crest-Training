-- Database: mydata

-- DROP DATABASE IF EXISTS mydata;

CREATE DATABASE mydata
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

--1. Create table person

Create table person(
	person_id serial primary key,
	first_name varchar(20) not null,
	last_name varchar(20) not null
);

--2. Add age column

alter table person 
add column age int not null

select * from person

--3. Add nationality column

alter table person 
add column nationality varchar(20) not null

--4. Add email column

alter table person
add column email varchar(20) unique

--5. Rename table

alter table person
rename to persons

--6. Rename column

alter table persons
rename column age to person_age

--7. Drop column

alter table persons
drop column person_age

--8. Add age column

alter table persons
add column age int not null

select * from persons

--9. Change data type of column

alter table persons
alter column age type int
using age::integer

alter table persons
alter column age type varchar(20)

--10. set default value to a column

alter table persons
add column is_enable varchar(1)

alter table persons
alter column is_enable set default 'y'

--11. Insert data into table

insert into persons(first_name,last_name,nationality,age) values
('John','Benjamin','US',40)

select * from persons

--12. Add unique consatraint to column

create table web_links(
	link_id serial primary key,
	link_url varchar(250) not null,
	link_target varchar(20)
);

--13. Insert data into table

insert into web_links(link_url,link_target) values
('https://www.amazon.com','_blank')

select * from web_links

alter table web_links
add constraint unique_web_url unique(link_url)

alter table web_links
add column is_enable varchar(2)

insert into web_links(link_url,link_target,is_enable) values
('https://www.netflix.com','_blank','Y')

insert into web_links(link_url,link_target,is_enable) values
('https://www.CITI.com','_blank','N')

alter table web_links
add check (is_enable in ('Y','N'))

update web_links
set is_enable = 'Y'
where link_id = 3

select * from web_links