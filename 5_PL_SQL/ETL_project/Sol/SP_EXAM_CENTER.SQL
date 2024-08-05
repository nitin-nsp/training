SET serveroutput ON;
CREATE OR REPLACE
PROCEDURE SP_POPULATE_EXAM_CENTER(
    P_ETL_USER_ID IN VARCHAR2)
IS
  V_NAME        VARCHAR2(50);
  V_IS_ACTIVE   VARCHAR2(10);
  V_ADDRESS_ID  VARCHAR2(40);
  V_LOCATION_ID VARCHAR2(40);
  CURSOR CUR_CETNER
  IS
    SELECT * FROM SRC_CENTER;
BEGIN
  FOR REC IN CUR_CETNER
  LOOP
    BEGIN
      V_NAME     :=REC.NAME;
      V_IS_ACTIVE:=REC.ACTIVE_STATUS;
      BEGIN
        SELECT ID INTO V_ADDRESS_ID FROM TAR_ADDRESS WHERE REC.ADDRESS=ADDRESS;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
        V_ADDRESS_ID:='null';
      WHEN OTHERS then 
      dbms_output.put_line(' error here');
      END;
      BEGIN
        SELECT ID INTO V_LOCATION_ID FROM TAR_LOCATION WHERE REC.NAME=NAME;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
        V_LOCATION_ID:='null';
      END;
      INSERT
      INTO TAR_EXAM_CENTER
        (
          NAME,
          IS_ACTIVE,
          ADDRESS_ID,
          LOCATION_ID,
          created_by,
          UPDATED_BY
        )
        VALUES
        (
          V_NAME,
          V_IS_ACTIVE,
          V_ADDRESS_ID,
          V_LOCATION_ID,
          P_ETL_USER_ID,
          P_ETL_USER_ID
        );
      COMMIT;
      dbms_output.put_line('inserted  :  ' || V_LOCATION_ID ||' --- ' || V_ADDRESS_ID);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('No data found :  ' || V_LOCATION_ID ||' --- ' || V_ADDRESS_ID);
    END;
  END LOOP;
END SP_POPULATE_EXAM_CENTER;
/
BEGIN
  SP_POPULATE_EXAM_CENTER('nsp:12c');
END;
