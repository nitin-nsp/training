DECLARE
V_DEPARTMENT_ID NUMBER;
v_count PLS_INTEGER := 0;             
v_total_sal PLS_INTEGER := 0;         
v_orderdate DATE := SYSDATE + 7;
C_TAX_RATE CONSTANT NUMBER(3,2) := 8.25;
V_VALID BOOLEAN NOT NULL := TRUE;
BEGIN
V_DEPARTMENT_ID:=9;
SELECT COUNT(*),sum(salary)
INTO V_COUNT,v_total_sal
FROM EMPLOYEES 
WHERE DEPARTMENT_ID=V_DEPARTMENT_ID;

DBMS_OUTPUT.PUT_LINE('number of employees in department ' || V_DEPARTMENT_ID||' : '|| V_COUNT);

 -- selary sum 
 
 SELECT SUM(SALARY)
 INTO V_TOTAL_SAL 
 FROM EMPLOYEES
 WHERE DEPARTMENT_ID=V_DEPARTMENT_ID;
 
 DBMS_OUTPUT.PUT_LINE('salary of employees in department ' || V_DEPARTMENT_ID||' : '|| V_TOTAL_SAL);

END;
/

SELECT COUNT(*), SUM(SALARY)
  INTO v_combined
  FROM EMPLOYEES
  WHERE DEPARTMENT_ID = V_DEPARTMENT_ID;

DBMS_OUTPUT.PUT_LINE('number of employees in department ' || v_complex.V_DEPARTMENT_ID||' : '|| v_complex.v_total_sal);


complet_row employees_table's row ,
SELECT *
  INTO  complet_row
  FROM EMPLOYEES
  WHERE employees_id = 100;

select * 
into collection_of_row
from empoyees 
where DEPARTMENT_ID=9

DBMS_OUTPUT.PUT_LINE('number of employees in department ' || v_complex.V_DEPARTMENT_ID||' : '|| v_complex.v_total_sal);
