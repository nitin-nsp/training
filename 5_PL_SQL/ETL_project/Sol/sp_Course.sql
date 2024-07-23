CREATE OR REPLACE PROCEDURE sp_course(p_etl_user_id in  VARCHAR2) IS
    v_is_active VARCHAR2(10) := 'TRUE';
    v_base_course VARCHAR2(10) := 'TRUE';
    
    CURSOR CUR_COURSE_NAME IS
        SELECT DISTINCT COURSE_NAME FROM src_courseenrollment;
    
BEGIN
    FOR REC IN CUR_COURSE_NAME LOOP
        INSERT INTO TAR_COURSE (NAME, BASE_course, is_active, created_by, updated_by)
        VALUES (REC.COURSE_NAME, v_base_course, v_is_active, p_etl_user_id, p_etl_user_id);
        COMMIT;
    END LOOP;
END sp_course;
/

begin 
sp_course('nsp:12c');
end;
/
