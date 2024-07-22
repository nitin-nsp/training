--SET SERVEROUTPUT ON;
--1. Explicit Cursor:
--a) Create an explicit cursor named "employee_cursor" to retrieve the details of employees from the "employees" table.
--b) Open the cursor and fetch the first three records from the cursor.
--c) Display the employee ID, first name, last name, and hire date for each of the fetched records.
--d) Close the cursor.
-- sol.
--DECLARE
--  V_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
--  V_FNAME EMPLOYEES.FIRST_NAME%TYPE;
--  V_LNAME EMPLOYEES.LAST_NAME %TYPE;
--  V_HIREDATE EMPLOYEES.HIRE_DATE%TYPE;
--
--  CURSOR EMP_CURSOR
--  IS
--    SELECT EMPloyee_id,first_name,last_name,hire_date FROM employees;
--BEGIN
--  OPEN EMP_CURSOR;
--  LOOP
--    FETCH EMP_CURSOR INTO V_EMP_ID,V_FNAME,V_LNAME,V_HIREDATE;
--    EXIT WHEN EMP_CURSOR % NOTFOUND;
--
--    dbms_output.put_line(v_emp_id);
--  END LOOP;
--  CLOSE emp_cursor;
--END;
--/
--2. Cursor FOR LOOP:
--a) Write a PL/SQL block using a cursor FOR LOOP to display the names and salaries of all employees in the "employees" table.
--b) Ensure that the employees' names are displayed in uppercase and their salaries are increased by 10% before displaying them.
--
-- sol.
--DECLARE
--  CURSOR EMP_CURSOR
--  IS
--    SELECT * FROM EMPLOYEES;
--BEGIN
--  FOR REC IN EMP_CURSOR
--  LOOP
--    DBMS_OUTPUT.PUT_LINE('emp info: ' || REC.EMPLOYEE_ID||'  '||UPPER(REC.FIRST_NAME) ||'  '||(rec.salary*1.1));
--  END LOOP;
--END;
--/
--3. Explicit Cursor:
--a) Create an explicit cursor named "department_cursor" to retrieve department details from the "departments" table.
--b) Open the cursor and fetch the department name and manager ID for each department.
--c) Display the department name and manager ID for each record.
--d) Close the cursor.
--
DECLARE
  V_DEPART_NAME DEPARTMENTS.DEPARTMENT_NAME %TYPE;
  v_lname EMPLOYEES.LAST_NAME%type ;
  CURSOR DEPARTMENT_CURSOR
  IS
    SELECT DEPARTMENT_NAME,
      E.LAST_NAME
    FROM DEPARTMENTS D
    JOIN EMPLOYEES E
    ON d.department_id =e.department_id;
BEGIN
  OPEN DEPARTMENT_CURSOR;
  LOOP
    FETCH DEPARTMENT_CURSOR INTO V_DEPART_NAME,V_LNAME;
    EXIT
  WHEN DEPARTMENT_CURSOR %NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(V_DEPART_NAME || V_LNAME);
  END LOOP;
  CLOSE DEPARTMENT_CURSOR;
END;
/
--4. Cursor FOR LOOP with Nested Cursor:
--a) Create an explicit cursor named "department_cursor" to retrieve department IDs and names from the "departments" table.
--b) Use a cursor FOR LOOP to loop through each department record.
--c) For each department, create a nested cursor named "employee_cursor" to retrieve the names of employees who work in that department from the "employees" table.
--d) Use another cursor FOR LOOP to display the names of employees in each department.
DECLARE
  CURSOR DEPARTMENT_CURSOR IS
    SELECT DEPARTMENT_ID, department_name
    FROM DEPARTMENTS;
BEGIN
  FOR DEPART_ROW IN DEPARTMENT_CURSOR LOOP
    DECLARE
      CURSOR EMP_CURSOR IS
        SELECT FIRST_NAME, LAST_NAME
        FROM EMPLOYEES
        WHERE department_id =DEPART_ROW.department_id ;
    BEGIN
      FOR EMPLOY_ROW IN EMP_CURSOR LOOP
       
        DBMS_OUTPUT.PUT_LINE(EMPLOY_ROW.FIRST_NAME || ' ' || EMPLOY_ROW.LAST_NAME || ' works in department => ' || DEPART_ROW.department_name);
      END LOOP;
    END;
  END LOOP;
END;
/







/*

-- Set server output on to display results
SET SERVEROUTPUT ON;

-- Declare variables to hold department_id and department_name
DECLARE
  v_department_id departments.department_id%TYPE;
  v_department_name departments.department_name%TYPE;
  
  -- Explicit cursor to fetch department IDs and names
  CURSOR department_cursor IS
    SELECT department_id, department_name
    FROM departments;
  
  -- Cursor variable for employee names within each department
  CURSOR employee_cursor (p_department_id departments.department_id%TYPE) IS
    SELECT first_name || ' ' || last_name AS employee_name
    FROM employees
    WHERE department_id = p_department_id;
BEGIN
  -- Main cursor FOR LOOP to iterate through each department
  FOR department_rec IN department_cursor LOOP
    -- Assign values from the current department record
    v_department_id := department_rec.department_id;
    v_department_name := department_rec.department_name;
    
    -- Display department information
    DBMS_OUTPUT.PUT_LINE('Department: ' || v_department_name);
    
    -- Nested cursor FOR LOOP to iterate through employees in the current department
    FOR employee_rec IN employee_cursor(v_department_id) LOOP
      -- Display each employee's name
      DBMS_OUTPUT.PUT_LINE(' - ' || employee_rec.employee_name);
    END LOOP;
    
    -- Separate departments with a blank line for clarity
    DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
END;
/

*/
