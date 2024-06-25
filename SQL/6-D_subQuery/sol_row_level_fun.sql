--1
select 
e.last_name,
DATEDIFF(mm,e.hire_date,GETDATE())
from employees e;

--2
SELECT
CONCAT_WS(' ',last_name,'earns',salary,'monthly but wansts',3*salary) 
from employees;

--3
SELECT
last_name,
CONCAT( REPLICATE('$',15-len(salary)),salary)
from employees

-- SELECT
-- last_name,
--  lpad

-- from employees

--4
SELECT 
    last_name,
    hire_date,
    DATENAME(dw, hire_date) AS DAY
FROM 
    employees
ORDER BY 
    (DATEPART(dw, hire_date)+6)%8;




--5
SELECT 
last_name,
COALESCE(manager_id,-1)
from 
employees;

--6
SELECT 
last_name,
REPLICATE('*',salary/1000) EMPLOYEES_AND_THEIR_SALARIES,salary
from employees e;

--7
SELECT 
    e.last_name,
    CASE 
        WHEN j.job_title = 'President' THEN 'A'
        WHEN j.job_title = 'Stock Manager' THEN 'B'
        WHEN j.job_title = 'Programmer' THEN 'C'
        WHEN j.job_title= 'Sales Representative' THEN 'D'
        WHEN j.job_title = 'Stock Clerk' THEN 'E'
        ELSE '0'
    END AS GRADE,
    j.job_title 
FROM 
    employees e inner join jobs j on e.job_id=j.job_id;

