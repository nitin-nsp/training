SET SERVEROUTPUT ON;
-- 1 simple block
DECLARE
V_NAME VARCHAR2(100);
BEGIN
V_NAME:='Hello world';
DBMS_OUTPUT.PUT_LINE(V_NAME);
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('error: ');
END;
/



DECLARE 
EMPLOYEE_ID NUMBER(6);
BEGIN 
SELECT EMPLOYEE_ID
INTO EMPLOYEE_ID
FROM EMPLOYEES
WHERE LAST_NAME='Kochhar';
DBMS_OUTPUT.PUT_LINE(EMPLOYEE_ID);
END;
/

DECLARE
  V_NUM NUMBER(7, 2);  
BEGIN
  V_NUM := 12345.6789;
  DBMS_OUTPUT.PUT_LINE('v_num: ' || V_NUM);
END;
/


-- PLS_Interger is faster (than number) for arithmetic (use machine arithmetic) 

DECLARE
V_DEPARTMENT_ID NUMBER;
v_count PLS_INTEGER := 0;             
v_total_sal PLS_INTEGER := 0;         
v_orderdate DATE := SYSDATE + 7;
C_TAX_RATE CONSTANT NUMBER(3,2) := 8.25;
V_VALID BOOLEAN NOT NULL := TRUE;
BEGIN
V_DEPARTMENT_ID:=9;
SELECT COUNT(*)
INTO V_COUNT
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




DECLARE
  TYPE emp_summary_type IS RECORD(
    emp_count PLS_INTEGER,
    total_sal NUMBER(9,2)
  );

  v_combined emp_summary_type;
  V_DEPARTMENT_ID NUMBER;

BEGIN
  V_DEPARTMENT_ID := 9;

  SELECT COUNT(*), SUM(SALARY)
  INTO v_combined
  FROM EMPLOYEES
  WHERE DEPARTMENT_ID = V_DEPARTMENT_ID;


  DBMS_OUTPUT.PUT_LINE('Summary of employees in department ' || V_DEPARTMENT_ID || ': ' || v_combined.emp_count || ' => ' || v_combined.total_sal);


END;
/


-- using complete row as data type 
DECLARE
   complet_row EMPLOYEES%ROWTYPE;
  TYPE employee_collection IS TABLE OF EMPLOYEES%ROWTYPE;
  collection_of_rows employee_collection;

BEGIN
--  V_DEPARTMENT_ID := 9;

   SELECT *
  INTO complet_row
  FROM EMPLOYEES
  WHERE EMPLOYEE_ID = 100;
  
   DBMS_OUTPUT.PUT_LINE('Employee ID: ' || complet_row.EMPLOYEE_ID || ' ' || COMPLET_ROW.last_name);
 

--  SELECT * 
--  BULK COLLECT INTO COLLECTION_OF_ROW
--  FROM EMPLOYEES E
--  WHERE E.DEPARTMENT_ID=V_DEPARTMENT_ID;
  
  
END;
/

