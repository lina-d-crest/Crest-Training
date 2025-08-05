--1. Change to upper case

select upper('amazing postgresql');

select 
	upper(first_name) as first_name,
	upper(last_name) as last_name
from directors;

--2. Change to lower case

select lower('AMAZING POSTGRESQL');

--3. First letter Capital

select initcap ('amazing postgresql');

select initcap(concat(first_name,' ',last_name)) as full_name
from directors
order by first_name;

--4.LEFT Function

select left('ABCD',1);
select left('ABCD',-2);

--5. Get initial for all directors name

select left(first_name,1) as initial
from directors
order by first_name;

select left(first_name,1) as initial,
count(*) as total_init
from directors
group by 1
order by 1;

--6. RIGHT Function

select right('ABCD',1);
select right('ABCD',-2);

--7. Get last letter for all directors name

select right(first_name,1) as initial
from directors
order by first_name;

select right(first_name,1) as initial,
count(*) as total_init
from directors
group by 1
order by 1;

--8. Reverse Function

select reverse('amazing postgresql');
select reverse('lqsergtsop gnizama');

--9. split_part

select split_part('1,2,3',',',2);
select split_part('zero,one,two,three',',',2);
select split_part('A|B|C|D','|',2);

--10. Get the release year of all the movies

select movie_name,release_date,split_part(release_date::text,'-',1) as release_year
from movies;

select * from movies;

--11. Trim Function

select 
	trim(leading from '  amazing postgresql'),
	trim(trailing from 'amazing postgresql  '),
	trim('  amazing postgresql  ');

--12. Remove leading 0

select trim(leading '0' from cast (00001234 as text));

--13. LTRIM, RTRIM, BTRIM

select ltrim('yummy','y');
select rtrim('yummy','y');
select btrim('yummy','y');

--14. LPAD

select lpad('Data',10,'*');
select lpad('1111',8,'*');

--15. RPAD

select rpad('Data',10,'*');
select rpad('1111',8,'*');

--16. Draw a chart on movies total revenues

select 
	mv.movie_name,
	r.revenues_domestic,
	lpad('*',cast(trunc(r.revenues_domestic/10 )as int),'*') chart 
from movies mv
inner join movies_revenues r on r.movie_id = mv.movie_id
order by 3 desc
nulls last;

--17. Length function

select length('amazing postgresql');
select length(cast(100122 as text));

select char_length(' ');
select char_length(null);

select 
	first_name ||' '||last_name as full_name,
	length (first_name ||' '||last_name) as full_name_length
from directors
order by 2 desc;

--18. Position

select Position('ing' in 'amazing postgresql');
select Position('is' in 'This is a computer	');

--19. STRPOS

select strpos('World bank','bank');

select first_name,Last_name from directors where strpos(last_name,'on')>0;

--20. Substring

select substring('Whatt a wonderful World' from 1 for 4);
select substring('Whatt a wonderful World' from 5 for 10);

select 
	first_name,last_name,
	substring (first_name,1,1) as initial
from directors
order by last_name;

--21. Repeat function
 
select repeat('A', 4)
 
--22. Replace function
 
select replace ('ABC XYZ', 'X', '1');
 
select replace('What a wonderful world', 'a wonderful', 'an amazing');
 
select replace ('11122233','1','5');