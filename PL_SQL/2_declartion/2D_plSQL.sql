SET SERVEROUTPUT ON;
/*
1. Write a PL/SQL block to declare a variable named "salary" 
of type NUMBER and assign a value of 5000 to it. 
Display the value of the salary variable.

*/

DECLARE
  v_salary NUMBER := 5000;
BEGIN
  DBMS_OUTPUT.PUT_LINE(v_salary);
END;
/


/*
2. Write a PL/SQL block to declare two variables, 
"length" and "width", both of type NUMBER. Assign values of 10 and 5
to the variables, respectively. Calculate 
and display the area of a rectangle using these variables.*/
DECLARE
 V_LEN NUMBER:=10;
 V_WIDTH NUMBER:=5;
 
 BEGIN 
--  DBMS_OUTPUT.PUT_LINE(V_LEN*V_WIDTH);
  DBMS_OUTPUT.put(v_len,v_width);
  END;
/

/*3. Write a PL/SQL block to declare a variable named "message" of type VARCHAR2(100). Prompt the user to enter a message and assign it to the variable. Display the message in uppercase letters.*/

ACCEPT  input_msg  PROMPT 'enter msg';
DECLARE
MSG VARCHAR2(100);
BEGIN
MSG:='&input_msg';

DBMS_OUTPUT.put_line(UPPER(MSG));
END;
/
/*4. Write a PL/SQL block to declare two variables, "num1" and "num2", both of type NUMBER. Prompt the user to enter values for num1 and num2. Swap the values of the variables and display the new values.*/
ACCEPT INPUT_NUM1 PROMPT 'enter num1';
ACCEPT INPUT_NUM2 PROMPT 'enter num2';

DECLARE
NUM1 NUMBER;
NUM2 NUMBER;
BEGIN
NUM1:='&input_num1';
NUM2:='&input_num2';
DBMS_OUTPUT.PUT_LINE(NUM1);
DBMS_OUTPUT.PUT_LINE(NUM2);
NUM1:=NUM1+NUM2;
NUM2:=NUM1-NUM2;
NUM1:=NUM1-NUM2;


DBMS_OUTPUT.PUT_LINE(NUM1);
DBMS_OUTPUT.PUT_LINE(NUM2);

END;
/


/*
5. Write a PL/SQL block to declare a variable named "emp_count" of type NUMBER and initialize it to 0. Retrieve the count of employees from the HR schema's "employees" table and assign it to the "emp_count" variable. Display the value of "emp_count".
*/
DECLARE
V_EMP_COUNT NUMBER :=0;

BEGIN
SELECT COUNT(*)
INTO V_EMP_COUNT
FROM 
EMPLOYEES;
dbms_output.put_line(v_emp_count);
END;
/


/*

6. Create a PL/SQL block to declare a variable named "dept_name" of type VARCHAR2(50). Prompt the user to enter a department name and assign it to the "dept_name" variable. Use the HR schema's "departments" table and display the details of the department entered.
*/

--ACCEPT input_deptname PROMPT 'enter dept name: ';

DECLARE 
  V_DEPT_NAME VARCHAR2(50);
  v_dept_row departments%ROWTYPE;
BEGIN
--PROMPT 'enter dept name:;
  V_DEPT_NAME := '&enter';
    SELECT *
    INTO v_dept_row
    FROM departments
    WHERE department_name = V_DEPT_NAME;

    -- Display the department details
    DBMS_OUTPUT.put_line('Department ID: ' || v_dept_row.department_id);
  
END;
/


/*
7. Write a PL/SQL block to declare a variable named "avg_salary" of type NUMBER(10,2). Calculate the average salary of all employees in the HR schema's "employees" table and assign it to the "avg_salary" variable. Display the value of "avg_salary".
*/
DECLARE
V_AVG_SAL NUMBER(10,2):=0;

BEGIN
SELECT AVG(SALARY)
INTO V_AVG_SAL
FROM EMPLOYEES;
dbms_output.put_line('avg salary: ' ||v_avg_sal);
END;
/


--8
/*

8. Create a PL/SQL block to declare a variable named "employee_name" of type VARCHAR2(100). Prompt the user to enter an employee ID and assign it to a bind variable ":emp_id". Retrieve the name of the employee with the entered ID from the HR schema's "employees" table and assign it to the "employee_name" variable. Display the value of "employee_name".
*/
DECLARE
v_EMP_ID NUMBER;
v_employee_name varchar2(100);
BEGIN
V_EMP_ID :='&enter_emp_id';

SELECT FIRST_NAME
INTO V_EMPLOYEE_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID=V_EMP_ID;

DBMS_OUTPUT.put_line('employee_id: ' ||v_emp_id || ' employee_name: '||v_employee_name);

END;
/

--9
/*
9. Write a PL/SQL block to declare a variable named "new_salary" of type NUMBER(8,2). Prompt the user to enter an employee ID and a new salary value. Assign the new salary value to the employee with the entered ID in the HR schema's "employees" table. Use bind variables ":emp_id" and ":salary". Display a message indicating the successful update.
*/

DECLARE 
V_EMPID NUMBER;
v_new_Salary number(8,2);
BEGIN
V_EMPID :='&enter_emp_id';
v_new_salary:='&enter_salary';
UPDATE EMPLOYEES 
SET SALARY=V_NEW_SALARY
where employee_id=v_empid;
 
END;
/




DECLARE
    new_salary NUMBER(8, 2);  -- Declare variable for new salary
BEGIN
    -- Prompt user for input
    DBMS_OUTPUT.PUT('Enter Employee ID: ');
    :emp_id := &emp_id; -- Use bind variable for employee ID
    DBMS_OUTPUT.PUT('Enter New Salary: ');
    :salary := &salary; -- Use bind variable for new salary

    -- Update the salary for the employee with the entered ID
    UPDATE employees
    SET salary = :salary
    WHERE employee_id = :emp_id;

    -- Commit the transaction
    COMMIT;

    -- Display success message
    DBMS_OUTPUT.PUT_LINE('Salary updated successfully for Employee ID ' || :emp_id);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/
