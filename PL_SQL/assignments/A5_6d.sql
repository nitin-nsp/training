SET SERVEROUTPUT ON;
--1. Using FOR UPDATE OF:
--Write a PL/SQL block to increase the salary of employees in department
--60,80 and 90 by 10% using FOR UPDATE OF. Use the parameterized cursor.


declare
TYPE dept_id_list
is
  TABLE OF Employees.department_id%type;
  v_dept_ids dept_id_list := dept_id_list(60, 80, 90);
  
  
  
  CURSOR EMP_CURSOR (DEPART_ID EMPLOYEES.DEPARTMENT_ID%TYPE)
  IS
    SELECT employee_id,
      salary
    FROM EMPLOYEES
    where DEPARTMENT_ID = DEPART_ID for update of SALARY nowait;
    
    
--    
  v_emp_id EMPLOYEES.EMPLOYEE_ID%TYPE;
  v_emp_sal EMPLOYEES.SALARY%TYPE;
--  v_dept_id EMPLOYEES.DEPARTMENT_ID%TYPE;
--  
  

  
BEGIN
  FOR I IN 1..V_DEPT_IDS.COUNT
  LOOP
    OPEN EMP_CURSOR(V_DEPT_IDS(i));
    LOOP
      FETCH EMP_CURSOR INTO v_emp_id, v_emp_sal;
      EXIT
    WHEN EMP_CURSOR%NOTFOUND;
      UPDATE EMPLOYEES SET SALARY = v_emp_sal * 1.10 WHERE CURRENT OF EMP_CURSOR;
    END LOOP;
    CLOSE EMP_CURSOR;
  END LOOP;
END;
/


SET SERVEROUTPUT ON;
DECLARE
TYPE dept_id_list
IS
  TABLE OF NUMBER;
  v_dept_ids dept_id_list := dept_id_list(60, 80, 90);
BEGIN
  FOR i IN 1..v_dept_ids.COUNT
  LOOP
    -- Retrieve current department ID from the collection
    DBMS_OUTPUT.PUT_LINE('Processing department ID: ' || v_dept_ids(i));
    -- Example: Query or manipulate data using v_dept_ids(i)
  END LOOP;
END;
/


--2. Using WHERE CURRENT OF:
--Assume you have a cursor "emp_cursor" that selects employee records from the "Employees" table.
--WRITE A PL/SQL BLOCK TO UPDATE THE SALARY OF THE CURRENT ROW FETCHED BY THE CURSOR USING WHERE CURRENT OF.
DECLARE
  CURSOR SAL_CUR
  IS
    SELECT DEPARTMENT_ID,SALARY FROM EMPLOYEES FOR UPDATE OF salary nowait ;
BEGIN
  FOR EMP_RECORD IN SAL_CUR
  LOOP
    IF emp_record.salary<6000 THEN
      UPDATE EMPLOYEES SET SALARY=EMP_RECORD.SALARY*1.1 WHERE CURRENT OF SAL_CUR;
    END IF;
  END LOOP;
END;
/