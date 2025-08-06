--1. Get total count of all movies group by movie language

select movie_lang,count(movie_lang) as total_movies 
from movies
group by movie_lang;

--2. Get average movie length group by movie language

select movie_lang,avg(movie_length) as avg_movie_length 
from movies
group by movie_lang
order by movie_lang;

--3. Get the sum of total movie length per age certificate

select sum(movie_length)  as sum_age_certificate ,age_certificate
from movies
group by age_certificate
order by age_certificate;

--4. Get min and max movie length group by movie language

select movie_lang,min(movie_length) as min_movie_length,max(movie_length) as max_movie_length
from movies
group by movie_lang
order by movie_lang;

--5. Use group by without aggeregate function

select movie_length
from movies
group by movie_length;

--6. Can we use column1, aggeregate function column without specifying group by claus?

select movie_lang,min(movie_length) as min_movie_length,max(movie_length) as max_movie_length
from movies
group by movie_lang
order by max(movie_length) desc;

--7.Get average movie length group by movie language and age certification

select movie_lang,age_certificate,avg(movie_length) as avg_movie_length
from movies
group by movie_lang,age_certificate
order by movie_lang;

--8. Can we not use group by on all colunms?

select movie_lang,age_certificate,avg(movie_length) as avg_movie_length
from movies
group by movie_lang,age_certificate
order by movie_lang;

--9. lets filter some records too
 
select movie_lang,age_certificate,avg(movie_length) as "Avg Movie Length"
from movies
where movie_length > 100
group by movie_lang, age_certificate

--10. Get avg movie length group by movie age certificate where age certificate = 10
 
select age_certificate,avg(movie_length)
from movies
where age_certificate = 'PG'
group by age_certificate
 
--11. How many directors are there per each nationality
 
select nationality,count(*) as "Total Directors"
from directors
group by nationality
order by 2 desc;
 
--12. Get total sum movie length for each age certificate and movie langauge combination
 
select movie_lang,age_certificate,sum(movie_length)
from movies
group by movie_lang, age_certificate
 
--13. List movies languages where sun total length of the movies is greater than 200
 
select movie_lang,sum(movie_length)
from movies
group by movie_lang
having sum(movie_length) > 200
order by movie_lang;

--14. List directors where their sum total movie length is greater than 200

select director_id,sum(movie_length)
from movies
group by director_id
having sum(movie_length) > 200
order by director_id;

--15. can we use column aliases with having claus? --NO

select director_id,sum(movie_length) as total
from movies
group by director_id
having total > 200
order by director_id;

--16. Get the movie languages where their sum total movie length is greater then 200
 
select movie_lang,sum(movie_length)
from movies
group by movie_lang
having sum(movie_length) > 200
order by 2 desc;
 
--17. Create test table employee_test

create table employee_test	(
	employee_id serial primary key,
	employee_name varchar(100),
	department varchar(100),
	salary int
);

insert into employee_test(employee_name,department,salary) values
('John','Finance',2500),
('Mary',null,3000),
('Adam',null,4000),
('Bruce','Finance',4000),
('Linda','IT',5000),
('Megan','IT',4000);

select * from employee_test;

--18. Display all department

select * 
from employee_test
order by department;

--19. How many employees are there in each group

select department,count(employee_name) as total
from employee_test
group by department
order by department;

--20. Handle Null values

select coalesce(department,'No department'),count(employee_name) as total
from employee_test
group by department
order by department;

select * from employee_test;