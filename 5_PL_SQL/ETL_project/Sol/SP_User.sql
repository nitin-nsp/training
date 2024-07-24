SET serveroutput ON;
CREATE OR REPLACE
PROCEDURE SP_POPULATE_USER(
    P_ETL_USER_ID IN VARCHAR2)
IS
--  V_USER_ID         VARCHAR2(36);
  V_FIRST_NAME      VARCHAR2(50);
  V_LAST_NAME       VARCHAR2(50);
  V_MIDDLE_NAME     VARCHAR2(50);
  V_GENDER          VARCHAR2(10):='Male';
  V_IS_ACTIVE       VARCHAR2(10):='TRUE';
  V_CONTACT_NUMBER  VARCHAR2(50) ;
  V_MANABADI_EMAIL  VARCHAR2(200);
  V_PERONSAL_EMAIL  VARCHAR2(200);
  V_TMP_SRC_ADDRESS VARCHAR2(250);
  V_ADDRESS_ID      VARCHAR2(50);
  CURSOR CUR_SRC_USER
  IS
    SELECT * FROM SRC_USER;
BEGIN
  FOR REC IN CUR_SRC_USER
  LOOP
     begin
--    V_USER_ID        :=SYS_GUID();
    V_FIRST_NAME     :=REC.FIRST_NAME;
    V_LAST_NAME      :=REC.LAST_NAME;
    V_MIDDLE_NAME    :=REC.MIDDLE_NAME;
    V_CONTACT_NUMBER :=REC.CONTACT_NUMBER;
    V_MANABADI_EMAIL :=REC.MANABADI_ID;
    V_PERONSAL_EMAIL :=REC.EMAIL;
    V_TMP_SRC_ADDRESS:=REC.ADDRESS;
    
    SELECT id INTO V_ADDRESS_ID FROM tar_address WHERE address=V_TMP_SRC_ADDRESS;
   -- dbms_output.put_line('error-> : '||V_ADDRESS_ID);
    INSERT
    INTO TAR_USER
      ( FIRST_NAME,
        LAST_NAME,
        MIDDLE_NAME,
        GENDER,
        IS_ACTIVE,
        CONTACT_NUMBER,
        MANABaDI_EMAIL,
        personal_email,
        ADDRESS_ID,
        CREATED_BY,
        updated_by
      )
      VALUES
      (
        V_FIRST_NAME,
        V_LAST_NAME,
        V_MIDDLE_NAME,
        V_GENDER,
        V_IS_ACTIVE,
        V_CONTACT_NUMBER,
        V_MANABADI_EMAIL,
        V_PERONSAL_EMAIL,
        V_ADDRESS_ID,
        P_ETL_USER_ID,
        P_ETL_USER_ID
      );
       dbms_output.put_line('instered : ' ||   V_ADDRESS_ID );
      --commit;
	    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    
      dbms_output.put_line('No data found for region_name: ' ||  V_ADDRESS_ID);
    END;
  END LOOP;
END SP_POPULATE_USER;
/

begin 
SP_POPULATE_USER('nsp:12c');
end;
/

