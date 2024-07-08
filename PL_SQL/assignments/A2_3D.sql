SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET define ON;
--1. Implicit Cursors:
--a What is an implicit cursor in PL/SQL? Explain its purpose and characteristics.
/*
sol: implicit cursor are inbuilt cursor or pointor sort of thing that keep pointing to last excuated query.
and it has some characteristics properties which they can access
*/
--b) Write a PL/SQL block that uses an implicit cursor to fetch and display the names of all employees from the "employees" table.
--2. Write a PL/SQL block to retrieve and display the details of an employee with a specific ID. Prompt the user to enter the employee ID as input.
--2
DECLARE
  V_EMP_ROW EMPLOYEES %ROWTYPE;
BEGIN
  SELECT * INTO V_EMP_ROW FROM EMPLOYEES WHERE EMPLOYEE_ID= '&ENTER_EMP_ID';
  DBMS_OUTPUT.PUT_LINE('emp info: ' || V_EMP_ROW.FIRST_NAME || V_EMP_ROW.LAST_NAME);
END;
/
--
--3. Write a PL/SQL block that inserts a new department record into the "departments" table. Prompt the user to enter the department name and location as input.
DECLARE
  V_DEPART_NAME DEPARTMENTS.DEPARTMENT_NAME %TYPE;
  V_LOCATION LOCATIONS.LOCATION_ID          %TYPE;
BEGIN
  V_DEPART_NAME:='&DEPART_NAME';
  V_LOCATION   :=&LOCATION_ID;
  INSERT
  INTO DEPARTMENTS
    (
      DEPARTMENT_ID,
      DEPARTMENT_NAME,
      LOCATION_ID
    )
    VALUES
    (
      12,
      V_DEPART_NAME,
      V_LOCATION
    );
  IF SQL%FOUND THEN
    DBMS_OUTPUT.PUT_LINE('intersert into department');
  ELSE
    DBMS_OUTPUT.PUT_LINE('not found some error:');
  END IF;
  DBMS_OUTPUT.PUT_LINE('everything woking' ||V_DEPART_NAME ||V_LOCATION);
END;
/
--4. Write a PL/SQL block to handle the NO_DATA_FOUND exception while fetching an employee's details based on a given employee ID. Display a custom message when the exception occurs.
DECLARE
  V_TMP NUMBER;
BEGIN
  SELECT COUNT(*) INTO V_TMP FROM EMPLOYEES WHERE EMPLOYEE_ID=&ENTER_ID;
  IF SQL%NOTFOUND THEN
    DBMS_OUTPUT.PUT_LINE('no data found');
  ELSE
    DBMS_OUTPUT.PUT_LINE('some data is found');
  END IF;
END;
/
--5. Transaction Management:
--a) Write a PL/SQL block that transfers an employee from one department to another. Update the "departments" table and the "employees" table to reflect the change. Ensure that both updates are treated as a single transaction and are committed only if both succeed.
--b) Create a stored procedure that allows updating an employee's job title and salary simultaneously. If the job title is updated successfully, but the salary update fails, the procedure should roll back the job title change.
--
--6. Write a PL/SQL block to retrieve the employee details (employee_id, first_name, last_name, and salary) from the "employees" table for a given department ID (prompt user). If no employees are found, display "No employees found for the given department."
--
--7. Create a PL/SQL block that increases the salary of all employees in the "sales" department by 10%. Display the affected employee IDs and their updated salaries.
DECLARE
  CURSOR EMP_CURSOR
  IS
    SELECT *
    FROM EMPLOYEES
    WHERE department_id =
      ( SELECT department_id FROM departments
      WHERE DEPARTMENT_NAME='Sales'
      );
BEGIN

FOR  EMP_REC IN EMP_CURSOR LOOP
 
 UPDATE EMPLOYEES 
 SET SALARY =SALARY*1.1
 WHERE EMPLOYEE_ID=EMP_REC.EMPLOYEE_ID;
 
 dbms_output.put_line('emp->' 
END;
/
--8. Write a PL/SQL block that deletes all employees who have a salary less than 3000 and hire date older than 5 years. Display the count of deleted employees.
--
DECLARE
  V_CNT NUMBER := 0;
BEGIN
  SELECT COUNT(*)
  INTO V_CNT
  FROM EMPLOYEES
  WHERE SALARY                                        < 3000
  AND TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 5;
  DBMS_OUTPUT.PUT_LINE('Count select: ' || V_CNT);
  --  DELETE EMPLOYEES
  --  WHERE SALARY                                        < 3000
  --  AND TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 5;
  IF SQL%ROWCOUNT >0 THEN
    DBMS_OUTPUT.PUT_LINE('Count delete: ' || SQL%ROWCOUNT);
  END IF;
END;
/
--9. Write a PL/SQL block to insert a new record into the "employees" table.
DECLARE
  v_newRecord employees%ROWTYPE;
BEGIN
  V_NEWRECORD.EMPLOYEE_ID:=1;
  v_newRecord.last_name
END;
/
--4