--1
--select 
--d.department_name,
--rank(){(over
--avg(e.salary) over (partition by d.department_id) as avg_salary,
--
--from
--employees e
--join
--departments d on e.department_id = d.department_id;
select
    DEPARTMENT_NAME,
    dense_rank() over (
        order by
            AVGSALARY
    ) as RANK
from
    (
        select
            D.DEPARTMENT_NAME,
            AVG(E.SALARY) as AVGSALARY
        from
            EMPLOYEES E
            join DEPARTMENTS D on E.DEPARTMENT_ID = D.DEPARTMENT_ID
        group by
            D.DEPARTMENT_NAME
    ) TMP;

--2
select
    E.FIRST_NAME,
    E.HIRE_DATE,
    E.DEPARTMENT_ID,
    dense_rank() over (
        partition by E.DEPARTMENT_ID
        order by
            TRUNC(MONTHS_BETWEEN(sysdate, E.HIRE_DATE) / 12) desc
    ) as RNK
from
    EMPLOYEES E;

--3 
select
    E.FIRST_NAME,
    E.SALARY,
    E.EMPLOYEE_ID,
    LEAD(E.SALARY) over(
        order by
            E.HIRE_DATE
    ) - E.SALARY as SALARY_DIFF
from
    EMPLOYEES E;

--4
select
    EMP.FIRST_NAME,
    EMP.SALARY,
    EMP.EMPLOYEE_ID,
    EMP.SALARY_DIFF
from
    (
        select
            E.FIRST_NAME,
            E.SALARY,
            E.EMPLOYEE_ID,
            LEAD(E.SALARY, 1, 0) over (
                order by
                    E.HIRE_DATE
            ) - E.SALARY as SALARY_DIFF
        from
            EMPLOYEES E
    ) EMP
order by
    EMP.SALARY_DIFF desc;

--5
select
    E.*,
    ROUND(YI.YEAR1 / E.SALARY * 100,2) as "Percent Increment Year 1",
    ROUND(YI.YEAR2 / (E.SALARY + YI.YEAR1) * 100,2) as "Percent Increment Year 2",
    ROUND(YI.YEAR3 / (E.SALARY + YI.YEAR1 + YI.YEAR2)*100,2) as "Increment Year 3",
    ROUND(YI.YEAR4 / (E.SALARY + YI.YEAR1 + YI.YEAR2 + YI.YEAR3)*100,2) as "Increment Year 4"
from
    YEARLYINCREMENT YI
    left join EMPLOYEES E on YI.EMPLOYEE_ID = E.EMPLOYEE_ID;
