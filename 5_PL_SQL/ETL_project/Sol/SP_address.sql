SET serveroutput ON;
CREATE OR REPLACE
PROCEDURE SP_POPULATE_ADDRESS(
    P_ETL_USER_ID IN VARCHAR2)
IS
  v_ADDRESS_id VARCHAR2(36) ;
  V_ADDRESS    VARCHAR2(1000);
  V_CITY       VARCHAR2(100) := 'NY';
  V_COUNTRY    VARCHAR2(100) := 'USA';
  V_STATE      VARCHAR2(100) := 'Manhattan';
  V_ZIPCODE    VARCHAR2(20)  := '10001';
  CURSOR CUR_SRC_ADDRESS
  IS
    ( SELECT ADDRESS FROM SRC_USER
  UNION
  SELECT ADDRESS FROM SRC_CENTER
  UNION
  SELECT ACADEMIC_SCHOOL FROM src_courseenrollment
    );
  BEGIN
    FOR REC IN CUR_SRC_ADDRESS
    LOOP
      BEGIN
        V_ADDRESS   :=REC.address;
        v_ADDRESS_id:=sys_guid();
        INSERT
        INTO tar_address
          (
            ID,
            ADDRESS,
            CITY,
            COUNTRY,
            STATE,
            ZIPCODE,
            CREATED_BY,
            UPDATED_BY
          )
          VALUES
          (
            v_ADDRESS_id,
            V_ADDRESS,
            V_CITY,
            V_COUNTRY,
            V_STATE,
            V_ZIPCODE,
            P_ETL_USER_ID,
            P_ETL_USER_ID
          );
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('VALUE: ' || V_ADDRESS);
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No data found for region_name: ' || V_ADDRESS);
      END;
    END LOOP;
  END SP_POPULATE_ADDRESS;
  /
  
  
  begin
  SP_POPULATE_ADDRESS('nsp:12c');
  end;
