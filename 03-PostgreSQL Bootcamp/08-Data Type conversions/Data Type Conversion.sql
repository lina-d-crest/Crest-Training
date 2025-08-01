--Type Conversion Example

--1. integer = integer

select * from movies
where movie_id = 1

--2. integer = string

select * from movies
where movie_id = '1'

--3. Use Explicit Conversion

select * from movies
where movie_id = integer'1'

--4. String to integer Conversion

select cast('10' as integer)

--5. String to date Conversion

select cast('2020-01-01' as date)
select cast('01-MAY-2020' as date)

--6. String to boolean Conversion

select cast('true' as boolean)
select cast('false' as boolean)
select cast('T' as boolean)
select cast('F' as boolean)

select 
	cast('0' as boolean),
	cast('1' as boolean)

--7. String to double Conversion

select 
	cast('14.788' as double precision),
	cast('12.74387463' as double precision)

-- 8. Using ::

select
	'10' :: integer,
	'2020-01-01' :: date

--9. String to timestamp Conversion

select '2020-01-01 10:30:25.407' :: timestamp
select '2020-01-01 10:30:25.407' :: timestamptz

--10. String to interval Conversion

select 
	'10 minutes' :: interval,
	'4 hours' :: interval,
	'1 day' :: interval,
	'2 week' :: interval,
	'5 month' :: interval
	
--11. Using integer as factorial

select factorial(5) as result;

--12. Integer to bigint

select factorial(cast(5 as bigint)) as result

--13. Round with numeric

select round(10,4)
select round(cast(5 as numeric),4) as result

--14. Cast with text

select substr('12345',2) as result

select 
	substr('123456', 2) as "Implicit",
	substr(cast('123456' as text),2) as "Explicit"
 
 
-- TABLE DATA CONVERSION
--15. Create a table called 'ratings' with initial data as character
 
create table ratings(
	rating_id serial primary key,
	rating varchar(1) not null
);
 
--16. Insert some data
 
insert into ratings (rating) values ('A'),('B'),('C'),('D')
 
select * from ratings
 
--17. Want Rating in integer
 
insert into ratings (rating) values (1),(2),(3),(4);
 
select * from ratings;
 
--18. Convert all values in the rating column into integers
 
select rating_id,
	case when rating~E'^\\d+$' then 
	cast (rating as integer)
	else 0
	end as rating
from ratings