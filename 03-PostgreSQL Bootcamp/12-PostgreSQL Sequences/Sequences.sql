--1. Create Sequence

create Sequence if not exists test_seq

--2. Advance sequence and return new value

select nextval ('test_seq')

--3. Return most current value of the sequence

select currval('test_seq')

--4. Set a sequence

select setval('test_seq',100)

--5. Set a sequence and do not skip over

select setval('test_seq',200,False)

--6. Control the sequence start value 

create Sequence if not exists test_seq2 start with 100

--7. Alter a Sequence

select nextval('test_seq')

Alter Sequence test_seq restart with 100

Alter Sequence test_seq rename to my_sequence4 



