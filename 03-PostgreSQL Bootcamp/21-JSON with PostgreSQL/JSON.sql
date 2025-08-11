--1. Represent JSON Object

select '{"title":"The lord of the rings"}'::text;

--2. Cast into JSON Object

select '{"title":"The lord of the rings"}'::json;

--3. Remove white space

select '{"title":"The lord of the rings","Author":"J.R.R"}'::jsonb;

--4. Create table books

create table books(
	book_id serial primary key,
	book_info jsonb
);

--5. Insert Json data

insert into books (book_info) values 
('{
	"title":"Book title2",
	"author":"author2"
}'),
('{
	"title":"Book title3",
	"author":"author3"
}'),
('{
	"title":"Book title4",
	"author":"author4"
}');

insert into books (book_info) values 
('{
	"title":"Book title10",
	"author":"author10"
}');

--6. View table

select * from books;

--7. Use selector

select book_info -> 'title' from books;
select book_info -> 'title' as Title, book_info -> 'author' as Author from books;

--8. Return as text

select book_info ->> 'title' from books;

--9. Filter records

select 
	book_info ->> 'title' as Title, 
	book_info ->> 'author' as Author 
from books
where book_info ->> 'author' = 'author1';

--10. Update author10 to Adnan

update books
set book_info = book_info || '{"author":"Adnan"}'
where book_info ->> 'author' = 'author10';

update books
set book_info = book_info || '{"title":"The future 1.0"}'
where book_info ->> 'author' = 'Adnan';

--11. Add additional field with boolean value

update books
set book_info = book_info || '{"best_seller":"true"}'
where book_info ->> 'author' = 'Adnan';

select * from books;

--12. Add Multiple key values

update books
set book_info = book_info || '{"category":"Science","pages":250}'
where book_info ->> 'author' = 'Adnan';

--13. Delete best seller

update books
set book_info = book_info - 'best_seller'
where book_info ->> 'author' = 'Adnan'
returning *;

--14. Add nested array data in json

update books
set book_info = book_info || '{"availability_location":["New York","New Jersey"]}'
where book_info ->> 'author' = 'Adnan'
returning *;

--15. Delete from array via path #-

update books
set book_info = book_info #- '{availability_location,1}'
where book_info ->> 'author' = 'Adnan'
returning *;

--16. Give output directors table into json format

select row_to_json(directors) from directors;

--17. Take few data from directors

select row_to_json(t) from
(
	select director_id,first_name,last_name,nationality
	from directors
) as t;

--18. List movie for each director

select *,
(
	select json_agg(x) as all_movies from
	(
		select movie_name
		from movies
		where director_id = directors.director_id
	) as x	
)
from directors;

--19. select director_id,first_name,last_name and all movies created by director

select director_id,first_name,last_name,
(
	select json_agg(x) as all_movies from
	(
		select movie_name
		from movies
		where director_id = directors.director_id
	) as x	
)
from directors;


--20. Build JSON array

select json_build_array(1,2,3,4,5);
select json_build_array(1,2,3,4,5,'Hi');

--21. key/value format

select json_build_object(1,2,3,4,5,'Hi');
select json_build_object('name','Adnan','email','a@b.com');

select json_object('{name,Adnan}','{email,a@b.com}');

--22. Create sample table

create table directors_docs(
	id serial primary key,
	body jsonb
);

--23. Insert data

insert into directors_docs (body)
select row_to_json(a)::jsonb from
(
	select director_id,first_name,last_name,date_of_birth,nationality,
	(
		select json_agg(x) as all_movies from
		(
			select movie_name
			from movies
			where director_id = directors.director_id
		) x	
	)
	from directors
)as a;

select * from directors_docs;

--24. Populate the data with empty array elements for all_movies

delete from directors_docs;

insert into directors_docs (body)
select row_to_json(a)::jsonb from
(
	select director_id,first_name,last_name,date_of_birth,nationality,
	(
		select case count(x) when 0 then '[]' else json_agg(x) end as all_movies from
		(
			select movie_name
			from movies
			where director_id = directors.director_id
		) x	
	)
	from directors
)as a;

select * from directors_docs;
select jsonb_array_elements(body -> 'all_movies') from directors_docs;

--25. Count total movies for each directors

select *,jsonb_array_length(body->'all_movies') as total_movies
from directors_docs
order by jsonb_array_length(body->'all+movies') desc;
 
--26. List all the keys within each JSON row
 
select *,jsonb_object_keys(body)
from directors_docs;
 
--27. What is you want to see key/value style output
 
select j.key,j.value
from directors_docs, jsonb_each(directors_docs.body)j;
 
--28. Turning JSON document to table format
 
select j.*
from directors_docs, jsonb_to_record(directors_docs.body) j 
(
	director_id INT,
	first_name VARCHAR(255)
);

--29. Find all first name equal to 'John'
 
select *
from directors_docs
where body->'first_name' ? 'John';

--30. Find all records with director_id=1

select *
from directors_docs
where body @> '{"director_id":1}';

--31. Find the record for movie name toy story

select *
from directors_docs
where body -> 'all_movies' @> '[{"movie_name":"Toy Story"}]';

--32. Find all records first name starting with 'J'

select *
from directors_docs
where body ->> 'first_name' like 'J%';

--33. Find all records where director_id > 2

select *
from directors_docs
where (body ->> 'director_id'):: integer > 2;

--34. Find all records where director_id is in 1,2,3,4,5 and 10.

select *
from directors_docs
where (body ->> 'director_id'):: integer in (1,2,3,4,5,10);

--35. Load data from contacts_docs

select * from contacts_docs;

--36. Find all first name equal to 'John'
 
select *
from contacts_docs
where body->'first_name' ? 'John';

--37. Execution time to run this query

explain analyze select *
from contacts_docs
where body->'first_name' ? 'John';

--38. Create gin index

create index idx_gin_contacts_docs_body on contacts_docs using gin(body);
select pg_size_pretty(pg_relation_size('idx_gin_contacts_docs_body'::regclass)) as index_name;

create index idx_gin_contacts_docs_body_cool on contacts_docs using gin(body jsonb_path_ops);
select pg_size_pretty(pg_relation_size('idx_gin_contacts_docs_body_cool'::regclass)) as index_name;