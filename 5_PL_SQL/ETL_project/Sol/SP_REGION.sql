set serveroutput on;
CREATE OR REPLACE
PROCEDURE SP_REGION(
    P_ETL_USER_ID IN VARCHAR2)
IS
  V_REGION_ID   VARCHAR2(36);
  V_NAME        VARCHAR2(20);
  V_DESCRIPTION VARCHAR2(20);
  CURSOR CUR_REGION
  IS
    SELECT * FROM SRC_REGION;
BEGIN
  FOR REC IN CUR_REGION
  LOOP
   begin 
    V_REGION_ID  :=SYS_GUID();
    V_NAME       :=REC.REGION_NAME;
    V_DESCRIPTION:=REC.REGION_NAME;
    INSERT
    INTO TAR_REGION
      (
        ID,
        NAME,
        DESCRIPTION,
        CREATED_BY,
        UPDATED_BY
      )
      VALUES
      (
        V_REGION_ID,
        V_NAME,
        V_DESCRIPTION,
        P_ETL_USER_ID,
        P_ETL_USER_ID
      );
      commit;
	  dbms_output.put_line('inserted : ' || V_REGION_ID);
	  EXCEPTION
      WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No data found : ' || V_REGION_ID);
      END;
  END LOOP;
END SP_REGION;
/

begin 
SP_REGION('nsp:12c');
end;
/