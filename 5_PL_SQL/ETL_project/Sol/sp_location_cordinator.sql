CREATE OR REPLACE
PROCEDURE sp_location_cordinatior(
    p_ETL_user_id in VARCHAR2)
IS
  CURSOR cur_center
  IS
    SELECT * FROM src_center;
  v_is_primary  NUMBER(1);
  v_location_id VARCHAR2(40);
  v_user_id     VARCHAR2(40);
  v_len         NUMBER;
BEGIN
  FOR rec IN cur_center
  LOOP
    
    
    SELECT COUNT(*) INTO v_len FROM tar_location_cordinator;
	
	
	IF v_len       =0 THEN
      v_is_primary:=1;
    ELSE
      v_is_primary:=0;
	END IF;
	
	
    SELECT id INTO v_location_id FROM tar_location WHERE name=rec.region;
    SELECT id INTO v_user_id FROM WHERE rec.COORDINATORS =user.personal_email;
	
	
	
    INSERT
    INTO tar_location_cordinator
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
  END LOOP;
END;
/