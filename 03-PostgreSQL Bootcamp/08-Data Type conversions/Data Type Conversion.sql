--Type Conversion Example

--1. integer = integer

select * from movies
where movie_id = 1

--2. integer = string

select * from movies
where movie_id = '1'

--3. USe Explicit Conversion

select * from movies
where movie_id = integer'1'

--4. string to integer Conversion

select cast('10' as integer)

--5. string to date Conversion

select cast('2020-01-01' as date)
select cast('01-MAY-2020' as date)

--6. string to boolean Conversion

select cast('true' as boolean)
select cast('false' as boolean)
select cast('T' as boolean)
select cast('F' as boolean)

select 
	cast('0' as boolean),
	cast('1' as boolean)

--7. string to double Conversion

select 
	cast('14.788' as double precision),
	cast('12.74387463' as double precision)

-- 8. Using ::

select
	'10' :: integer,
	'2020-01-01' :: date

--9. string to timestamp Conversion

select '2020-01-01 10:30:25.407' :: timestamp
select '2020-01-01 10:30:25.407' :: timestamptz

--10. string to interval Conversion

select 
	'10 minutes' :: interval,
	'4 hours' :: interval,
	'1 day' :: interval,
	'2 week' :: interval,
	'5 month' :: interval
	
--11. Using integer as factorial

select factorial(5) as result;

--12. integer to bigint

select factorial(cast(5 as bigint)) as result

--13. Round with numeric

select round(10,4)
select round(cast(5 as numeric),4) as result

--14. cast with text

select substr('12345',2) as result

select 
	substr('123456', 2) as "Implicit",
	substr(cast('123456' as text),2) as "Explicit"
 
 
-- TABLE DATA CONVERSION
--15. create a table called 'ratings' with initial data as character
 
create table ratings(
	rating_id serial primary key,
	rating varchar(1) not null
);
 
--16. let's insert some data
 
insert into ratings (rating) values ('A'),('B'),('C'),('D')
 
select * from ratings
 
--17. now rating want in integer
 
insert into ratings (rating) values (1),(2),(3),(4);
 
select * from ratings;
 
--18. now, we have to convert all values in the rating column into integers
 
select rating_id,
	case when rating~E'^\\d+$' then 
	cast (rating as integer)
	else 0
	end as rating
from ratings

--19.  convert integer into string
 
select to_char(100870,'9,9999');
 
--20. view movie  release  data in DD-MM-YYYY format
 
select release_date,TO_CHAR(release_date, 'DD-MM-YYYY'),TO_CHAR(release_date, 'Dy, MM, YYYY')
from movies;
 
--21. convertig timestamp literal to a string
 
select TO_CHAR(timestaMp '2020-01-01 10:30:45','HH24:MI:SS');
 
--22. Adding currency symbol to say movie revenues

select * from movies_revenues
 
select movie_id,revenues_domestic,TO_CHAR(revenues_domestic, '$99999D99')
from movies_revenues;
 
-- TO_NUMBER
--23. convert a string to a number
 
select TO_NUMBER('1456.76','9999.')
select TO_NUMBER('10,654.78-','99G999D99S')
 
--24. formating
 
select to_number('$1,423.65','L9G999D99')
select to_number('1,234,546.89','9G999g999')
select to_number('1,234,432.88','9G999g999D99')
 
--25. converting say money number
 
select to_number('1,987,288.87','L9G999g999.99')
 
--26. string to date
 
select TO_DATE('2020/10/22','YYYY/MM/DD')
select TO_DATE('022199','MMDDYY')
SELECT TO_DATE('March 07, 1999','Month DD, YYYY')
 
--27. Error Handling
 
select TO_DATE('2020/10/30','YYYY/MM/DD')
 
--28. To timestamp
 
select to_timestamp('2020-10-28 10:30:23','YYYY-MM-DD HH:MI:SS')
 
--29. It skip spaces
 
select to_timestamp('2020 may', 'YYYY MON');
 
--30. minimal erro is checking!!
 
select to_timestamp('2020-01-01 22:8:00','YYYY-MM-DD HH24:MI:SS');
 