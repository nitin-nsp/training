SET serveroutput ON;
CREATE OR REPLACE
PROCEDURE sp_course(
    p_etl_user_id IN VARCHAR2)
IS
  v_course_name  src_courseenrollment.COURSE_NAME%type;
  
  v_is_active   VARCHAR2(10) := 'TRUE';
  v_base_course VARCHAR2(10) := 'TRUE';
  CURSOR CUR_COURSE_NAME
  IS
    SELECT DISTINCT COURSE_NAME FROM src_courseenrollment;
BEGIN
  FOR REC IN CUR_COURSE_NAME
  LOOP
    BEGIN
    v_course_name:=rec.v_course_name;
      INSERT
      INTO TAR_COURSE
        (
          NAME,
          BASE_course,
          is_active,
          created_by,
          updated_by
        )
        VALUES
        (
         v_course_name,
          v_base_course,
          v_is_active,
          p_etl_user_id,
          p_etl_user_id
        );
      COMMIT;
      dbms_output.put_line('INSERTed :  1' );
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('No data found :  ' );
    END;
  END LOOP;
END sp_course;
/

BEGIN
  sp_course('nsp:12c');
END;
/
