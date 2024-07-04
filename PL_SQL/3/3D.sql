SET SERVEROUTPUT ON;
SET VERIFY OFF;
set define on;
  
--  1
DECLARE 


--2
DECLARE
V_EMP_ROW EMPLOYEES %rowtype;

BEGIN
 SELECT * 
 INTO V_EMP_ROW
 FROM EMPLOYEES
 WHERE employee_id= '&ENTER_EMP_ID';
 
 dbms_output.put_line('emp info: ' || v_emp_row.first_name || v_emp_row.last_name);
END;
/

--3
DECLARE
V_DEPART_NAME DEPARTMENTS.DEPARTMENT_NAME % TYPE;
v_location  Locations.location_id %type;
BEGIN
V_DEPART_NAME:='&DEPART_NAME';
V_LOCATION:=&LOCATION_id;
INSERT INTO DEPARTMENTS(DEPARTMENT_ID,DEPARTMENT_NAME,LOCATION_ID) 
VALUES (12,V_DEPART_NAME,V_LOCATION);

IF SQL%FOUND THEN 
DBMS_OUTPUT.PUT_LINE('intersert into department');
ELSE 
DBMS_OUTPUT.PUT_LINE('not found some error:');
END IF;

dbms_output.put_line('everything woking'||V_DEPART_NAME||V_LOCATION);

END;
/

--4
DECLARE 
v_tmp number;
BEGIN

SELECT COUNT(*)
into v_tmp
FROM EMPLOYEES
WHERE EMPLOYEE_ID=&ENTER_ID;

IF SQL%NOTFOUND THEN
DBMS_OUTPUT.PUT_LINE('no data found');
ELSE
DBMS_OUTPUT.PUT_LINe('some data is found');
end if;
END;
/