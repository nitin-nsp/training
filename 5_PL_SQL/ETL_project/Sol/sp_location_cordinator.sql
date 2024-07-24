set serveroutput on;


CREATE OR REPLACE
PROCEDURE sp_location_cordinatior(
    p_ETL_user_id IN VARCHAR2)
IS
  CURSOR cur_center
  IS
    SELECT * FROM src_center;
  v_is_primary  NUMBER(1);
  v_location_id VARCHAR2(40);
  v_user_id     VARCHAR2(40);
  v_len         NUMBER:=0;
BEGIN
  FOR rec IN cur_center
  LOOP
    BEGIN
      SELECT COUNT(*) INTO v_len FROM tar_location_coordinator;
      IF v_len       =0 THEN
        v_is_primary:=1;
      ELSE
        v_is_primary:=0;
      END IF;
      SELECT id INTO v_location_id FROM tar_location WHERE name=rec.region;
      SELECT id INTO v_user_id FROM tar_user WHERE MANABADI_EMAIL= rec.COORDINATORS ;
      INSERT
      INTO tar_location_coordinator
        (
          is_primary,
          location_id,
          user_id,
          created_by,
          updated_by
        )
        VALUES
        (
          v_is_primary,
          v_location_id,
          v_user_id,
          p_ETL_user_id,
          p_ETL_user_id
        );
      COMMIT;
      dbms_output.put_line('INSERTed :  ' || v_user_id ||' --- ' || v_location_id);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('No data found :  ' || v_user_id ||' --- ' || v_location_id);
    END;
  END LOOP;
END sp_location_cordinatior ;
/

begin 
sp_location_cordinatior('nsp:12c');
end;