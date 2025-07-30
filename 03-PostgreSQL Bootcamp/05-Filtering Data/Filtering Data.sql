--1. where clause

select *
from movies
where movie_lang = 'English'

--2. Get all Japanese language movies

select *
from movies
where movie_lang = 'Japanese'
	
--3. Get movies with English language and age certificate is 18

select * 
from movies
where movie_lang = 'English'
	and age_certificate = '18'

--4. Get all English or Japanese movies

select *
from movies
where movie_lang = 'Japanese'
	or movie_lang = 'English'

--5. Get all English movie and director id is equal to 10

select *
from movies
where movie_lang = 'English'
	and director_id = '10'

--Combining OR + AND operator
--6. Get all english or japanese movies

select *
from movies
where (movie_lang = 'Japanese'
	or movie_lang = 'English')
	and age_certificate = '12'
order by movie_lang;

--7. Combing AND with OR

select *
from movies
where (movie_lang = 'English'
	and age_certificate = '12')
	or movie_lang = 'Japanese'
order by movie_lang;

--LOGICAL OPERATOR
--8. Get all movie has length over 100

select * 
from movies
where movie_length > 100
order by movie_length DESC;

--9. Get all movies that release after 2000

select * 
from movies
where release_date > '2002-12-31'

--10. using <

select *
from movies
where movie_lang < 'English'

--11. Top 5 longest movies

select *
from movies
order by movie_length DESC
LIMIT 5

--12. Top 5 oldest american directors

select *
from directors
where nationality = 'American'
order by date_of_birth DESC
LIMIT 5

--13. Top 10 oldest female actress

select *
from actors
where gender = 'F'
order by date_of_birth DESC
LIMIT  10

--14. List 5 longest movies after top 5 longest movies

select *
from movies
order by movie_length DESC
LIMIT 5 OFFSET 5

--15. List 5 movies after the top 5 movies in movies_id order wise(from id-6 to id-10)

select *
from movies
order by movie_id
LIMIT 5 OFFSET 5

--16. FETCH first 5 rows from the movies length

select *
from  movies
fetch first 5 rows only

--17. Get first 5 movies from the fifth record by length

select *
from movies
order by movie_length  DESC
FETCH FIRST 5  ROWS ONLY
OFFSET 5

--In and Not in
--18. Get all English, Japanese movies

SELECT *
FROM movies
WHERE movie_lang IN ('English', 'Japanese')
ORDER BY movie_lang

--19. Get age_certificate which is in PG and in 12

SELECT *
FROM movies
WHERE age_certificate IN ('12', 'PG')

--20. Get all movies where director are not 12 and 10

SELECT *
FROM directors
where director_id NOT IN (10, 13)
order by director_id 

--21. Get all actora where id is not 1,2,3,4

SELECT *
FROM actors
where actor_id NOT IN (1,2,3,4)
order by actor_id 

--Between
--22. Get all the actors whose birth are between 1991 and 1995

select *
from actors
where date_of_birth BETWEEN '1991-01-01' AND '1995-01-01'

--23. Get all movies released between 1998 and 2002.

select *
from movies
where release_date between '1998-01-01' and '2002-12-31'
order by release_date

--24. Get all the movies where domestic revenue between 100 and 300.

select *
from movies_revenues
where revenues_domestic between '100' and '300'
order by revenues_domestic

--25. Get all English movies where movie length between 100 and 200

select *
from movies
where movie_lang = 'English' and movie_length between '100' and '200'
order by movie_length

--Like and ILike
--26. Full Character Search

select 'hello' like 'hello'

--27. Partial character search using 'g'

select 'hello' like 'h%'
select 'hello' like '%e'
select 'hello' like 'hell%'
select 'hello' like '%ll'

--28. Single character search using '_'

select 'hello' like '_ello'

--29. Checking occurance of search using '_'

select 'hello' like '__ll_'

--30. Using % and _ together

select 'hello' like '%ll_'

--31. Get all Actors name where first name starting with 'A'

select *
from actors
where first_name like 'A%'

--32. Get all Actors name where last name ending with 'a'

select *
from actors
where last_name like '%a'

--33. Get all Actors name where first name with 5 character only

select *
from actors
where first_name like '_____'

--34. Get all Actors name where first name contains 'l' on second place

select *
from actors
where first_name like '_l%'

--35. Get records of an actors where actor name is 'Tim'

select *
from actors
where first_name like 'tim'

--ILike is not case-sensitive
--36. Get records of an actors where actor name is 'Tia'

select *
from actors
where first_name ilike 'tim'

--null and is not null
--37. Find list of actors with missing birth dates

select *
from actors
where date_of_birth is null

--38. Find list of actors with missing birth dates or first name

select *
from actors
where 
	date_of_birth is null
	or first_name is null

--39. Get the list of movies where domestic revenue is missing.

select * 
from movies_revenues
where revenues_domestic is null
	
--40. Get the list of movies where either domestic or international revenue is missing.

select * 
from movies_revenues
where 
	revenues_domestic is null
	or revenues_international is null

--41. Get the list of movies where  domestic revenue is not  missing.

select * 
from movies_revenues
where revenues_domestic is not null

--42. Use of = null

select * 
from movies_revenues
where revenues_domestic = 'null'

--Conactenation
--43. combine 'Hello' and 'World'
--Using ||

select 'Hello ' || 'World'

--44. Concat two colunm

select 
	revenues_domestic,
	revenues_international,
	concat(revenues_domestic,' | ',revenues_international) as profits
from movies_revenues

--concat_ws

select 
	revenues_domestic,
	revenues_international,
	concat_ws('|',revenues_domestic,revenues_international) as profits
from movies_revenues

--45. first name,last name ,dob

select
	first_name,
	last_name,
	date_of_birth
from actors

select
	concat_ws(',',first_name,last_name,date_of_birth)
from actors

