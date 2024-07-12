--1. create a STORED procedure named "GET_EMPLOYEES" THAT RETURNS all EMPLOYEE
--details from the "employees" table.
-- Define the collection type

CREATE OR REPLACE TYPE EMP_TABLE_TYPE
as
  TABLE OF EMPLOYEES%ROWTYPE ;
DECLARE


BEGIN

END;
/
  
  
CREATE OR REPLACE
PROCEDURE GET_EMPLOYEES(
    EMP_REC OUT EMP_TABLE_TYPE)
IS
  CURSOR ALL_EMP
  IS
    SELECT * FROM EMPLOYEES;
  I BINARY_INTEGER := 1;
  CUR_ROW EMPLOYEES%ROWTYPE;
BEGIN
  OPEN ALL_EMP;
  LOOP
    FETCH ALL_EMP INTO CUR_ROW;
    EXIT
  WHEN ALL_EMP%NOTFOUND;
    EMP_REC(I) := CUR_ROW;
    I          := I + 1;
  END LOOP;
  CLOSE ALL_EMP;
END GET_EMPLOYEES;
/
DECLARE
Type Emp_Table_Type
IS
  TABLE OF EMPLOYEES%ROWTYPE INDEX BY BINARY_INTEGER;
  
  
  Emp_Rec Emp_Table_Type;
BEGIN
  Get_Employees(Emp_Rec) FOR Emp_Row IN Emp_Rec
  LOOP
    Dbms_Output.Put_Lin(Emp_Row.Last_Name);
  END LOOP;
END;
/
--2. modify the "GET_EMPLOYEES" STORED procedure to ACCEPT AN INPUT PARAMETER
--"department_id"
-- AND RETURN ONLY THE EMPLOYEES WHO BELONG TO THAT DEPARTMENT.
CREATE OR REPLACE
PROCEDURE GET_EMPLOYEES(
    d_id IN employees.department_id%type,
    EMP_REC OUT EMP_TABLE_TYPE)
IS
  CURSOR ALL_EMP
  IS
    SELECT * FROM EMPLOYEES WHERE department_id=d_id;
  I BINARY_INTEGER := 1;
  CUR_ROW EMPLOYEES%ROWTYPE;
BEGIN
  OPEN ALL_EMP;
  LOOP
    FETCH ALL_EMP INTO CUR_ROW;
    EXIT
  WHEN ALL_EMP%NOTFOUND;
    EMP_REC(I) := CUR_ROW;
    I          := I + 1;
  END LOOP;
  CLOSE ALL_EMP;
END GET_EMPLOYEES;
/
DECLARE
Type Emp_Table_Type
IS
  TABLE OF Employees%Rowtype INDEX BY Binary_Integer;
  Emp_Rec Emp_Table_Type;
BEGIN
  Get_Employees(Emp_Rec) FOR Emp_Row IN Emp_Rec
  LOOP
    Dbms_Output.Put_Lin(Emp_Row.Last_Name);
  END LOOP;
END;
/
--3. create a STORED procedure named "GET_EMPLOYEES_IN_DEPT" THAT ACCEPTS a
--department ID as an input parameter.
--   use a cursor to FETCH all EMPLOYEE NAMES and SALARIES for the GIVEN
--   department and display the results.
--4. create a new object type "employee_type" with attributes for
--"employee_id," "first_name," "last_name," and "salary."
--   Create a nested table type "employee_table" using the "employee_type"
--   object type.
--   write a STORED procedure named "INSERT_EMPLOYEES" THAT ACCEPTS AN array
--   of employee records (employee_table) as input
--   and inserts them into the "employees" table.
--   the procedure SHOULD HANDLE the SITUATION when the PROVIDED DEPARTMENT
--   ID does not exist in the "DEPARTMENTS" table.
--   in SUCH CASES, IT SHOULD RAISE a CUSTOM EXCEPTION and DISPLAY AN APPROPRIATE
--   error message.
--5. create a STORED procedure named "UPDATE_SALARY_BATCH" THAT TAKES AN array of
--employee IDs and a percentage increase as inputs.
--   the procedure SHOULD update the SALARIES of the EMPLOYEES WHOSE IDS ARE in the
--   input array with the given percentage increase.
CREATE OR REPLACE TYPE EMP_ID_ARR
AS
  TABLE OF EMPLOYEES.EMPLOYEE_ID%TYPE;
  
  
CREATE OR REPLACE
PROCEDURE UPDATE_SALARY_BATCH(
    P_EMP_ID  IN EMP_ID_ARR,
    P_PER_INC IN NUMBER)
IS
BEGIN
  FOR I IN 1.. P_EMP_ID.COUNT
  LOOP
    UPDATE EMPLOYEES
    SET SALARY       =SALARY*(1+P_PER_INC/100)
    WHERE EMPLOYEE_ID=EMP_ID_ARR(I);
  END LOOP;
END;
/

DECLARE 
 V_EMP_IDS EMP_ID_ARR :=EMP_ID_ARR(100,101,102);
 V_PER NUMBER:=10;
 BEGIN 
  UPDATE_SALARY_BATCH(V_EMP_IDS,V_PER);
  
  EXCEPTION 
  WHEN OTHERS THEN 
  dbms_output.put_line('error: '|| sqlerrm); 
 END;
 /
