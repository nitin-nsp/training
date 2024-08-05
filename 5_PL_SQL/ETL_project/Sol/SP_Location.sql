set serveroutput on;

CREATE OR REPLACE
PROCEDURE sp_location(
    p_ETL_user_id IN VARCHAR2)
IS
  v_name src_center.name%TYPE;
  v_is_active  NUMBER(1) DEFAULT 0;
  v_is_default NUMBER(1) DEFAULT 0;
  v_region_id VARCHAR2(40) default null;
  v_address_id VARCHAR2(40) default null;
  CURSOR cur_src_center
  IS
    SELECT * FROM src_center;
BEGIN
  FOR rec IN cur_src_center
  LOOP
   begin 
    v_name             :=rec.name;
	
    IF rec.active_status='TRUE' THEN
      v_is_active      :=1;
    ELSE
      v_is_active:=0;
    END IF;
    
    
	begin
    SELECT id INTO v_region_id FROM tar_region WHERE name=rec.region;
	EXCEPTION 
	when NO_DATA_FOUND THEN
	v_region_id:='null';
	end;
	
	begin
    SELECT id INTO v_address_id FROM tar_address WHERE address=rec.address;
	EXCEPTION 
	when NO_DATA_FOUND THEN
	v_address_id:='null';
	end;
  
    INSERT
    INTO tar_location
      (
        name,
        is_active,
        is_default,
        region_id,
        address_id,
        created_by,
        updated_by
      )
      VALUES
      (
        v_name,
        v_is_active,
        v_is_default,
        v_region_id,
        v_address_id,
        p_ETL_user_id,
        p_ETL_user_id
      );
    COMMIT;
    
     dbms_output.put_line('INSERTED :  ' || v_region_id ||' --- ' || v_address_id);
	 
	  EXCEPTION
      WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No data found :  ' || v_region_id ||' --- ' || v_address_id);
      END;
	  
  END LOOP;
 
  
END sp_location ;
/

begin 
sp_location('nsp:12c');
end ;