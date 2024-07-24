set serveroutput on;

CREATE OR REPLACE
PROCEDURE sp_enrolled_course(
    p_etl_user_id IN VARCHAR2 )
IS
  CURSOR cur_course_enrollment
  IS
    SELECT * FROM src_courseenrollment;
  v_student_id          VARCHAR2(50) := SYS_GUID();
  v_academic_year       VARCHAR2(100);
  v_academic_grade      VARCHAR2(100);
  v_academic_school     VARCHAR2(1000);
  v_average_score       VARCHAR2(50);
  v_result              VARCHAR2(100);
  v_is_course_completed NUMBER(1);
  v_tshirt_size         VARCHAR2(100);
  v_course_id           VARCHAR2(100);
  v_center_id           VARCHAR2(100);
BEGIN
  FOR rec IN cur_course_enrollment
  LOOP
    BEGIN
      v_academic_year         := rec.academic_year;
      v_academic_grade        := rec.academic_grade;
      v_academic_school       := rec.academic_school;
      v_average_score         := rec.average_score;
      v_result                := rec.result;
      IF rec.course_completed  = 'TRUE' THEN
        v_is_course_completed := 1;
      ELSE
        v_is_course_completed := 0;
      END IF;
      v_tshirt_size := rec.shirt_size;
      SELECT id INTO v_course_id FROM tar_course WHERE rec.course_name=name;
      SELECT id INTO v_center_id FROM tar_exam_center WHERE name = rec.center_name;
      INSERT
      INTO tar_enrolled_course
        (
          STUDENT_ID,
          ACADEMIC_YEAR,
          ACADEMIC_GRADE,
          ACADEMIC_SCHOOL,
          AVERAGE_SCORE,
          RESULT,
          IS_COURSE_COMPLETED,
          TSHIRT_SIZE,
          COURSE_ID,
          CENTER_ID,
          CREATED_BY,
          UPDATED_BY
        )
        VALUES
        (
          v_student_id,
          v_academic_year,
          v_academic_grade,
          v_academic_school,
          v_average_score,
          v_result,
          v_is_course_completed,
          v_tshirt_size,
          v_course_id,
          v_center_id,
          p_etl_user_id,
          p_etl_user_id
        );
      COMMIT;
      dbms_output.put_line('INSERTed :  ' || v_course_id ||' --- ' || v_center_id);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('No data found :  ' || v_course_id ||' --- ' || v_center_id);
    END;
  END LOOP;
END sp_enrolled_course;
/

begin 
sp_enrolled_course('nsp:12c');
end;



