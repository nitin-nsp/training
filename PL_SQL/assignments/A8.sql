SET serveroutput ON;
--1. Write a PL/SQL function called `calculate_area` that takes two parameters: `length` and `width`.
--The function should calculate and return the area of a rectangle. Test the function with different input values.
--
CREATE OR REPLACE
  FUNCTION CALCULATE_AREA(
      L IN NUMBER,
      B IN NUMBER)
    RETURN NUMBER
  IS
    V_AREA NUMBER :=1;
  BEGIN
    V_AREA:=L*B;
    RETURN V_AREA;
  END CALCULATE_AREA;
  /
  BEGIN
    dbms_output.put_line(CALCULATE_AREA(10,5));
  END;
  /
  --2. Create a PL/SQL function called `reverse_string` that takes a string as input
  --and returns the reverse of the input string.
  --Test the function with various strings, including empty strings.
  --
CREATE OR REPLACE
FUNCTION REVERSE_STRING(
    STR IN VARCHAR2)
  RETURN VARCHAR2
IS
  temp_str VARCHAR2(32767);
BEGIN
  IF LENGTH(STR) = 0 THEN
    RETURN '';
  END IF;
  temp_str := REVERSE(STR);
  RETURN temp_str;
END REVERSE_STRING;
/
BEGIN
  DBMS_OUTPUT.PUT_LINE(REVERSE_STRING('nitins') || ' ' || REVERSE_STRING('singh') || ' ' || REVERSE_STRING('a'));
END;
/
--3. Write a PL/SQL function called `safe_division` that takes two parameters: `numerator` and `denominator`.
--The function should perform division and handle the scenario where the `denominator` is zero by returning NULL.
--Test the function with different input values, including a zero denominator.
--
CREATE OR REPLACE
FUNCTION SAFE_DIVISION(
    N IN NUMBER,
    D IN NUMBER)
  RETURN FLOAT
IS
  ANS FLOAT;
BEGIN
  IF D = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Division by zero error');
  END IF;
  ANS := N / D;
  RETURN ANS;
END SAFE_DIVISION;
/
BEGIN
  DBMS_OUTPUT.PUT_LINE(SAFE_DIVISION(4, 2) || ' ' || SAFE_DIVISION(3, 2));
  DBMS_OUTPUT.PUT_LINE(SAFE_DIVISION(3, 0));
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' : ' || SQLERRM);
END;
/
--4.Create a function get_employee_count that takes a department ID as input
--and returns the count of employees in that department from an employees table.
--
CREATE OR REPLACE
FUNCTION get_employee_count(
    p_dId IN EMPLOYEES.EMPLOYEE_ID%TYPE)
  RETURN NUMBER
IS
  V_CNT NUMBER:=0;
BEGIN
  SELECT COUNT(*) INTO V_CNT FROM EMPLOYEES WHERE department_id=P_DID;
  RETURN V_CNT;
END get_employee_count;
/
BEGIN
  DBMS_OUTPUT.PUT_LINE(get_employee_count(9));
END ;
/
--5. Create a function get_employee_salary that takes an employee ID as input and returns the salary of the employee.
--Handle the case where the employee ID is not found by raising a custom exception.
--
CREATE OR REPLACE
FUNCTION GET_EMPLOYEE_SALARY(
    D_ID EMPLOYEES.EMPLOYEE_ID%TYPE)
  RETURN EMPLOYEES.SALARY%TYPE
IS
  v_sal EMPLOYEES.SALARY%TYPE;
BEGIN
  IF D_ID IS NULL THEN
    RAISE_APPLICATION_ERROR(-20001, 'Please provide an employee ID');
  END IF;
  SELECT SALARY INTO v_sal FROM EMPLOYEES WHERE EMPLOYEE_ID = D_ID;
  RETURN v_sal;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  RAISE_APPLICATION_ERROR(-20002, 'Employee ID ' || D_ID || ' not found');
END GET_EMPLOYEE_SALARY;
/
BEGIN
  DBMS_OUTPUT.PUT_LINE(GET_EMPLOYEE_SALARY(100));
  DBMS_OUTPUT.PUT_LINE(GET_EMPLOYEE_SALARY(NULL));
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(SQLCODE || ' : ' || SQLERRM);
END;
/
--6. Create a PL/SQL function named calculate_discount that takes the total amount as input
--and returns a discount amount based on the following conditions:
--If the total amount is less than 1000, apply a 5% discount.
--If the total amount is between 1000 and 5000, apply a 10% discount.
--If the total amount is greater than 5000, apply a 15% discount.
--
CREATE OR REPLACE
FUNCTION CALCULATE_DISCOUNT(
    TOTAL_AMT IN FLOAT)
  RETURN FLOAT
IS
  V_DIS FLOAT:=0;
BEGIN
  IF TOTAL_AMT   >5000 THEN
    V_DIS       :=TOTAL_AMT*0.15;
  ELSIF TOTAL_AMT>1000 THEN
    V_DIS       :=TOTAL_AMT*0.1;
  ELSE
    V_DIS:=TOTAL_AMT*0.05;
  END IF;
  RETURN V_DIS;
END CALCULATE_DISCOUNT;
/
BEGIN
  DBMS_OUTPUT.PUT_LINE(CALCULATE_DISCOUNT(6000) ||' '|| CALCULATE_DISCOUNT(4000) || ' '|| CALCULATE_DISCOUNT(500));
END;
/
--7. Create a PL/SQL package called `employee_pkg` to manage employee data. The package should contain:
--   a. A procedure to insert a new employee into the database.
--   b. A function to calculate the salary of an employee based on the input of hours worked and hourly rate.
--   c. A procedure to update the job title of an employee based on their ID.
--   d. A function to retrieve the number of employees in a specific department.
--
--Test each of the package procedures and functions with sample data.
CREATE OR REPLACE
PACKAGE employee_pkg
IS
  -- insert p
  PROCEDURE INSERT_EMPLOYEE(
      P_ID            IN EMPLOYEES.EMPLOYEE_ID%TYPE,
      P_F_NAME        IN EMPLOYEES.FIRST_NAME%TYPE,
      P_L_NAME        IN EMPLOYEES.LAST_NAME%TYPE,
      P_EMAIL         IN EMPLOYEES.EMAIL%TYPE,
      P_PHONE_NUM     IN EMPLOYEES.PHONE_NUMBER%TYPE,
      P_HIRE_DATE     IN EMPLOYEES.HIRE_DATE%TYPE,
      P_JOB_ID        IN EMPLOYEES.JOB_ID%TYPE,
      P_SALARY        IN EMPLOYEES.SALARY%TYPE,
      P_MANAGER_ID    IN EMPLOYEES.MANAGER_ID%TYPE,
      p_department_id IN EMPLOYEES.DEPARTMENT_ID%TYPE );
  -- salary cal fun
  FUNCTION calculate_salary(
      p_hours_worked IN NUMBER,
      p_hourly_rate  IN NUMBER )
    RETURN NUMBER;
  -- update job title update
PROCEDURE UPDATE_JOB_TITLE(
      P_ID        IN EMPLOYEES.EMPLOYEE_ID%TYPE,
      p_new_title IN jobs.job_title%type );
  --
  FUNCTION GET_EMPLOYEE_COUNT(
      P_department_id IN employees.department_id%type )
    RETURN NUMBER;
END employee_pkg;
/
CREATE OR REPLACE
PACKAGE BODY EMPLOYEE_PKG
IS
PROCEDURE INSERT_EMPLOYEE(
    P_ID            IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    P_F_NAME        IN EMPLOYEES.FIRST_NAME%TYPE,
    P_L_NAME        IN EMPLOYEES.LAST_NAME%TYPE,
    P_EMAIL         IN EMPLOYEES.EMAIL%TYPE,
    P_PHONE_NUM     IN EMPLOYEES.PHONE_NUMBER%TYPE,
    P_HIRE_DATE     IN EMPLOYEES.HIRE_DATE%TYPE,
    P_JOB_ID        IN EMPLOYEES.JOB_ID%TYPE,
    P_SALARY        IN EMPLOYEES.SALARY%TYPE,
    P_MANAGER_ID    IN EMPLOYEES.MANAGER_ID %TYPE,
    p_department_id IN EMPLOYEES.DEPARTMENT_ID%TYPE )
IS
BEGIN
  INSERT
  INTO EMPLOYEES
    (
      EMPLOYEE_ID,
      FIRST_NAME,
      LAST_NAME,
      EMAIL,
      PHONE_NUMBER,
      HIRE_DATE,
      JOB_ID,
      SALARY,
      MANAGER_ID,
      DEPARTMENT_ID
    )
    VALUES
    (
      P_ID,
      P_F_NAME,
      P_L_NAME,
      P_EMAIL,
      P_PHONE_NUM,
      P_HIRE_DATE,
      P_JOB_ID,
      P_SALARY,
      P_MANAGER_ID,
      P_DEPARTMENT_ID
    );
EXCEPTION
WHEN OTHERS THEN
  dbms_output.put_line('insert: error');
END INSERT_EMPLOYEE;


FUNCTION calculate_salary
  (
    P_HOURS_WORKED IN NUMBER,
    P_HOURLY_RATE  IN NUMBER
  )
  RETURN NUMBER
IS
  V_SAL NUMBER;
BEGIN
  V_SAL:=P_HOURS_WORKED*P_HOURLY_RATE;
  return v_sal;
END CALCULATE_SALARY;




PROCEDURE UPDATE_JOB_TITLE
  (
    P_ID        IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    p_new_title IN jobs.job_title%type
  )
IS

  p_job_id jobs.job_id%type;
BEGIN
   SELECT JOB_ID INTO P_JOB_ID FROM JOBS WHERE JOB_TITLE = P_NEW_TITLE;
   
   
  IF P_JOB_ID IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('No job found with title: ' || P_NEW_TITLE);
    RETURN; 
  END IF;
   UPDATE EMPLOYEES SET JOB_ID = P_JOB_ID WHERE EMPLOYEE_ID = P_ID;
EXCEPTION
WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No job found with title: ' || P_NEW_TITLE);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error updating job title for employee ' || P_ID || ': ' || SQLERRM);
END UPDATE_JOB_TITLE;


FUNCTION GET_EMPLOYEE_COUNT(
    P_DEPARTMENT_ID IN EMPLOYEES.DEPARTMENT_ID%TYPE )
  RETURN NUMBER
IS
  V_CNT NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_cnt
  FROM EMPLOYEES
  WHERE DEPARTMENT_ID=P_DEPARTMENT_ID;
  return v_cnt;
END GET_EMPLOYEE_COUNT;
END employee_pkg;
/


BEGIN 
--dbms_output.put_line(EMPLOYEE_PKG.CALCULATE_SALARY(10,5));
--DBMS_OUTPUT.PUT_LINE(EMPLOYEE_PKG.GET_EMPLOYEE_COUNT(6));
 EMPLOYEE_PKG.UPDATE_JOB_TITLE(100,'Programmer');
 
END;
/
--8. Develop a PL/SQL package called `bank_operations_pkg` to handle basic banking operations. The package should include:
--   a. A procedure to deposit an amount into an account.
--   b. A procedure to withdraw an amount from an account, ensuring the balance does not go negative.
--   c. A function to calculate the interest on the account balance based on the interest rate and time period.
--   d. A procedure to transfer funds from one account to another.


create 
--9. Create a package named order_management that allows adding and listing orders. It should include:
--
--A procedure to add an order (order ID, customer name, order total).
--A function to calculate the total revenue (sum of all order totals).
--A cursor to list all orders.
--
--10. Extend the order_management package with exception handling:
--
--MODIFY THE ADD ORDER PROCEDURE TO HANDLE CASES WHERE THE ORDER TOTAL IS NEGATIVE OR ZERO BY RAISING APPROPRIATE EXCEPTIONS.
--Handle these exceptions in a way that the caller receives a meaningful error message.