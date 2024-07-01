--1
select 
d.department_name,
rank(){(over
avg(e.salary) over (partition by d.department_id) as avg_salary,

from
employees e
join
departments d on e.department_id = d.department_id;

--2
SELECT 
e.first_name,
e.hire_date,
e.department_id,
Dense_rank() over (
partition by e.department_id 
order by TRUNC(MONTHS_BETWEEN(SYSDATE, e.hire_date) / 12) desc
) AS rnk
from
employees e;
--3 

select
e.first_name,
e.salary,
e.employee_id,
Lead(e.salary) over(order by e.hire_date) -e.salary as salary_diff
from 
employees e;

--4

select 
emp.first_name,
emp.salary,
emp.employee_id,
emp.salary_diff
from (
select
e.first_name,
e.salary,
e.employee_id,
lead(e.salary,1,0) OVER (ORDER BY e.hire_date) - e.salary AS salary_diff
from 
employees e
) emp
order by 
emp.salary_diff desc;
    
    



