CREATE TABLE MY_EMPLOYEE(
  id int,
  first_name varchar(100),
  last_name varchar(100),
  user_id varchar(100),
  salary int
);

-- drop table MY_EMPLOYEE;
INSERT INTO
  MY_EMPLOYEE(id, first_name, last_name, user_id, salary)
values
  (1, 'Rahual', 'Patel', 'rpatel', 895),
  (2, 'Betty', 'Danes', 'bdanes', 860),
  (3, 'Ban', 'Biri', 'bbiri', 1100),
  (4, 'Chad', 'nevman', 'cnevman', 750),
  (5, 'Andey', 'Rope', 'arope', 1550);

select
  *
from
  MY_EMPLOYEE;

UPDATE
  MY_EMPLOYEE
set
  last_name = 'Drexler'
where
  id = 3;

UPDATE
  MY_EMPLOYEE
set
  salary = 1000
WHERE
  salary < 900;

DELETE From
  MY_EMPLOYEE
WHERE
  first_name = 'betty'
  and last_name = 'Danes';

-- ALTER TABLE MY_EMPLOYEE MODIFY last_name VARCHAR(200);
-- CREATE TABLE MY_EMPLOYEE2 
SELECT
  *
FROM
  MY_EMPLOYEE;

ALTER TABLE
  MY_EMPLOYEE
ALTER column
  last_name VARCHAR(200) CREATE TABLE STUDENT(
    student_id int PRIMARY Key,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
  );

-- CREATE table courses (
-- course_id int ,
-- course_name 
-- )
/* 2-*/