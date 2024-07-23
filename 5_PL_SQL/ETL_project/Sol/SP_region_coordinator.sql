CREATE OR REPLACE
PROCEDURE sp_populate_region_coordinate(
    p_ETL_user_id IN VARCHAR2)
IS
  v_is_primary NUMBER(1) := 0;
  v_region_id  VARCHAR2(40);
  v_user_id    VARCHAR2(40);
  CURSOR cur_region
  IS
    SELECT * FROM src_region;
BEGIN
  FOR rec IN cur_region
  LOOP
    SELECT id INTO v_region_id FROM tar_region WHERE name=rec.region_name;
    
    SELECT id
    INTO v_user_id
    FROM tar_user
    WHERE personal_email=rec.regional_coordinator;
    SELECT COUNT(*) INTO v_is_primary FROM tar_region_coordinator;
    IF v_is_primary=0 THEN
      v_is_primary:=1;
    ELSE
      v_is_primary:=0;
    END IF;
    INSERT
    INTO tar_region_coordinator
      (
        is_primary,
        region_id,
        user_id,
        created_by,
        updated_by
      )
      VALUES
      (
        v_is_primary,
        v_region_id,
        v_user_id,
        p_ETL_user_id,
        p_ETL_user_id
      );
    
  END LOOP;
END;
/

begin 
sp_populate_region_coordinate('nsp:12c');
end;
/