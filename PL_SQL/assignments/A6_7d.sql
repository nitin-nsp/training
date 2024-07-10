--1.Create a PL/SQL anonymous block that performs the following actions:
--a) Open a cursor to fetch employee information.
--b) For each employee, attempt to divide their salary by 0. Handle the "ZERO_DIVIDE" exception at this level by displaying a custom error message for each employee.
--c) Handle any other exceptions that may occur during the loop by displaying a generic error message.
DECLARE
  CURSOR EMP_CUR
  IS
    SELECT salary FROM EMPLOYEES;
  v_salary employees.salary%type;
BEGIN
  OPEN EMP_CUR;
  LOOP
    FETCH EMP_CUR INTO V_SALARY;
    EXIT
  WHEN EMP_CUR%NOTFOUND;
    v_salary:=v_salary/0;
  END LOOP;
  CLOSE emp_cur;
EXCEPTION
WHEN ZERO_DIVIDE THEN
  DBMS_OUTPUT.PUT_LINE('error zeor: ' || SQLERRM);
END;
/
--2.Create a PL/SQL anonymous block that declares a nested table type to store
--integers. Initialize a nested table variable and insert some random integers
--into it. Then, loop through the nested table and display the elements.
--
--3.Create a PL/SQL anonymous block that uses a cursor to fetch
--EMPLOYEE NAMES FROM THE "employees" TABLE AND STORES THEM IN A
--COLLECTION (NESTED TABLE OR ASSOCIATIVE ARRAY). THEN, DISPLAY THE
--employee names from the collection.
DECLARE
TYPE EMP_NAME
IS
  TABLE OF EMPLOYEES.FIRST_NAME%TYPE INDEX BY BINARY_INTEGER;
  EMP_REC EMP_NAME;
BEGIN
  SELECT FIRST_NAME BULK COLLECT INTO EMP_REC FROM EMPLOYEES;
  FOR I IN EMP_REC.FIRST .. EMP_REC.LAST
  LOOP
    DBMS_OUTPUT.PUT_LINE(EMP_REC(I));
  END LOOP;
END;
/
--4.Write a PL/SQL anonymous block that uses a cursor to fetch
--EMPLOYEE SALARIES FROM THE "employees" TABLE. IF A SALARY IS GREATER
--than 10000, display it. Handle any exceptions that may occur.
DECLARE
  CURSOR EMP_SAL
  IS
    SELECT SALARY FROM EMPLOYEES;
  V_SALARY EMPLOYEES.SALARY%TYPE;
  very_less_salary EXCEPTION;
BEGIN
  OPEN EMP_SAL;
  LOOP
    FETCH EMP_SAL INTO V_SALARY;
    EXIT
  WHEN EMP_SAL%NOTFOUND;
    IF V_SALARY>5000 THEN
      DBMS_OUTPUT.PUT_LINE(V_SALARY);
    ELSE
      raise very_less_salary;
    END IF;
  END LOOP;
  CLOSE EMP_SAL;
EXCEPTION
WHEN VERY_LESS_SALARY THEN
  dbms_output.put_line('error: very less salary');
END;
/
--5. Create a PL/SQL anonymous block that handles the "NO_DATA_FOUND"
--exception for a select statement on the "employees" table. instead of
--displaying the default oracle error message, raise a custom exception
--with the error code -20101 and an error message "No employees found for
--the given criteria."
--
DECLARE
  v_salary employees.salary%type;
BEGIN
  SELECT salary INTO v_salary FROM employees WHERE SALARY <0;
EXCEPTION
WHEN no_data_found THEN
  RAISE_APPLICATION_ERROR(-20101,'ERROR: => WORKING NO EMPLOYEES FORUND FOR THE GIVEN CRITERIA');
END;
/
--6.Write a PL/SQL anonymous block that performs the following actions:
--a) Attempts to update an employee's salary in the "employees" table.
--b) Handle the "TOO_MANY_ROWS" exception and raise a custom exception with
--error code -20102 and an error message
--"More than one employee found for the given criteria."
--c) Handle the "NO_DATA_FOUND" exception and raise a custom exception with error
--code -20103 and an error message "No employee found for the given criteria."
--d) Handle all other exceptions by displaying a generic error message.
--
DECLARE
  CURSOR emp_sal
  IS
    SELECT employee_id, salary form employees;
BEGIN
EXCEPTION
WHEN TOO_MANY_ROWS THEN
  raise_application_error(-20102, 'error:-> More than one employee found for the given criteria.');
WHEN no_data_found THEN
  raise_application_error(-20103,'No employee found for the given criteria.');
WHEN OTHERS THEN
END;
/
--7.Create a PL/SQL anonymous block that prompts the user to enter an employee ID.
--Attempt to fetch the employee's name and salary from the "employees" table.
--If the employee is not found, raise a user-defined error with the error code
---20201
--and an error message "Employee ID not found." If the entered employee ID
--is negative, raise a user-defined error with the error code -20202 and
--an error message "Invalid employee ID entered."
--
DECLARE
  V_EMP_ID EMPLOYEES.EMPLOYEE_ID%type;
  v_employee_name EMPLOYEES.LAST_NAME%type;
BEGIN
  V_EMP_ID := '&ENTER_EMPLOYEE_ID';
  
  IF V_EMP_ID < 0 THEN
    RAISE_APPLICATION_ERROR(-20202, 'Error: Invalid employee ID entered');
  ELSE
    SELECT LAST_NAME INTO v_employee_name FROM EMPLOYEES WHERE EMPLOYEE_ID = V_EMP_ID;
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20201, 'Error: No data found');
END;
/

--8.Write a PL/SQL anonymous block that handles 
--  the "DUP_VAL_ON_INDEX" EXCEPTION when INSERTING 
--  a new DEPARTMENT RECORD into the "departments" table. 
--   instead of DISPLAYING the default ORACLE error MESSAGE,
--   RAISE a CUSTOM error using RAISE_APPLICATION_ERROR with 
--   the error code -20301 and an error message "Department ID already exists."
DECLARE
BEGIN
  INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME)
  VALUES (&enter_department_id, '&enter_name');
EXCEPTION 
  WHEN DUP_VAL_ON_INDEX THEN
    RAISE_APPLICATION_ERROR(-20301, 'Department ID already exists.');
END;
/

