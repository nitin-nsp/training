--1
SELECT
    e.last_name,
    d.department_name,
    d.department_id
from employees e inner join departments d on e.department_id=d.department_id;

--2 
SELECT
    *
from
    departments
WHERE department_id=8;

-- 3
SELECT last_name, department_name, location_id, city
FROM (
    SELECT l.*, d.department_name, d.department_id
    FROM departments d
        INNER JOIN locations l ON d.location_id = l.location_id
) AS t
    INNER JOIN employees e ON t.department_id = e.department_id;

--4
SELECT
    e.last_name,
    d.department_name,
    d.department_id
from
    employees e INNER join
    departments d on e.department_id=d.department_id
WHERE PATINDEX('%[a-z]%',last_name)>0


--5
SELECT last_name, department_name, location_id, city
FROM (
    SELECT l.*, d.department_name, d.department_id
    FROM departments d
        INNER JOIN locations l ON d.location_id = l.location_id
) AS t
    INNER JOIN employees e ON t.department_id = e.department_id
WHERE city='Toronto';

--6
SELECT
    e.last_name AS Employee,
    e.employee_id AS "Emp#",
    m.last_name AS Manager,
    m.employee_id AS "Mgr#"
FROM
    employees e
    INNER JOIN employees m ON e.manager_id = m.employee_id;

--7
SELECT
    e.last_name AS Employee,
    e.employee_id AS "Emp#",
    m.last_name AS Manager,
    m.employee_id AS "Mgr#"
FROM
    employees e
    left JOIN employees m ON e.manager_id = m.employee_id;

--10
SELECT
    e.first_name,
    e.last_name,
    e.hire_date
FROM
    employees e
WHERE  e.hire_date >(select hire_date
from employees
WHERE first_name='Daniel')


--11

-- SELECT
-- emp.first_name employee,
-- t.first_name
-- from
--     employees emp
-- where emp.hire_date> t.hire_date
-- (
--     select m.hire_date,m.first_name
--     from employees m where m.employee_id=emp.employee_id
-- ) as t


-- 13

SELECT
    MAX(salary), MIN(salary), AVG(salary), SUM(salary)
from employees

SELECT
    MAX(salary) max,
     MIN(salary) min,
      AVG(salary) avg,
       SUM(salary) sum
from employees
GROUP by job_id

-- 15
SELECT COUNT(job_id)
from 
employees 
GROUP by job_id;

--16

--17
SELECT
max(salary)-min(salary) DIFFERENCE
from 
employees;

--18
SELECT
manager_id,
min(salary) as minSalary
from 
employees 
GROUP by manager_id
HAVING 
minSalary >= 6000 and manager_id is not null

SELECT
manager_id,
min(salary) as minSalary
from 
employees 
GROUP by manager_id
HAVING 
min(salary)>=6000 and manager_id is not null




SELECT 
    d.department_id AS "dep no.",
    j.job_title AS "job title",
    AVG(e.salary) AS "avg sal",
    COUNT(e.employee_id) AS "no. of emp",
    SUM(e.salary) AS "total sal"
FROM 
    departments d
JOIN 
    employees e ON d.department_id = e.department_id
JOIN 
    jobs j ON e.job_id = j.job_id
WHERE 
    d.department_id IN (2, 5, 8, 9)
GROUP BY 
    d.department_id, j.job_title
ORDER BY 
    d.department_id, "total sal" DESC;
