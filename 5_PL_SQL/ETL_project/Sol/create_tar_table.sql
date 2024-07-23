----SELECT SYS_GUID() AS GENERATED_GUID FROM DUAL;
------
CREATE TABLE TAR_USER
  (
    ID             VARCHAR2(36) DEFAULT SYS_GUID() PRIMARY KEY,
    FIRST_NAME     VARCHAR2(50),
    LAST_NAME      VARCHAR2(50),
    MIDDLE_NAME    VARCHAR2(50),
    gender         VARCHAR2(10),
    is_active      VARCHAR2(10),
    contact_number VARCHAR2(50),
    manabadi_email VARCHAR2(200),
    personal_email VARCHAR2(200),
    address_id     VARCHAR2(40),
    created_by     VARCHAR2(50) NOT NULL,
    updated_by     VARCHAR2(50) NOT NULL,
    deleted_by     VARCHAR2(50) DEFAULT NULL
  );
CREATE TABLE tar_Region
  (
    ID          VARCHAR2(36) DEFAULT SYS_GUID() PRIMARY KEY,
    name        VARCHAR2(30),
    description VARCHAR2(30),
    CREATED_BY  VARCHAR2(36) NOT NULL,
    UPDATED_BY  VARCHAR2(36) NOT NULL,
    DELETED_BY  VARCHAR2(36) DEFAULT NULL
  );
CREATE TABLE tar_region_coordinator
  (
    ID         VARCHAR2(36) DEFAULT SYS_GUID() PRIMARY KEY,
    is_primary NUMBER(1) DEFAULT 0,
    region_id  VARCHAR2(40),
    user_id    VARCHAR2(40),
    --    CONSTRAINT fk_region FOREIGN KEY (region_id) REFERENCES tar_region(id),
    --    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES tar_user(id),
    CREATED_BY VARCHAR2(36) NOT NULL,
    UPDATED_BY VARCHAR2(36) NOT NULL,
    DELETED_BY VARCHAR2(36)
  );
CREATE TABLE tar_location
  (
    ID           VARCHAR2(36) DEFAULT SYS_GUID() PRIMARY KEY,
    name         VARCHAR2(70),
    is_active    NUMBER(1) DEFAULT 0,
    is_default   NUMBER(1) DEFAULT 0,
    start_time   TIMESTAMP DEFAULT TO_TIMESTAMP('09:00:00', 'HH24:MI:SS'),
    end_time     TIMESTAMP DEFAULT TO_TIMESTAMP('17:00:00', 'HH24:MI:SS'),
    class_timing TIMESTAMP DEFAULT TO_TIMESTAMP('10:00:00', 'HH24:MI:SS'),
    region_id    VARCHAR2(40) NOT NULL,
    address_id   VARCHAR2(40) NOT NULL,
    CREATED_BY   VARCHAR2(36) NOT NULL,
    UPDATED_BY   VARCHAR2(36) NOT NULL,
    DELETED_BY   VARCHAR2(36) DEFAULT NULL
  );
CREATE TABLE tar_location_coordinator
  (
    ID          VARCHAR2(36) DEFAULT SYS_GUID() PRIMARY KEY,
    is_primary  NUMBER(1) DEFAULT 0,
    location_id VARCHAR2(40),
    user_id     VARCHAR2(40),
    CREATED_BY  VARCHAR2(36) NOT NULL,
    UPDATED_BY  VARCHAR2(36) NOT NULL,
    DELETED_BY  VARCHAR2(36) DEFAULT NULL
  );
CREATE TABLE tar_exam_center
  (
    ID          VARCHAR2(36) DEFAULT SYS_GUID() PRIMARY KEY,
    name        VARCHAR2(100) UNIQUE,
   
    is_active   NUMBER(1,0 ),
    address_id  varchar2(40),
    location_id varchar2(40),
    
    CREATED_BY  VARCHAR2(36) NOT NULL,
    UPDATED_BY  VARCHAR2(36) NOT NULL,
    DELETED_BY  VARCHAR2(36) DEFAULT NULL
  );
CREATE TABLE tar_enrolled_course
  (
    ID                  VARCHAR2(36) DEFAULT SYS_GUID() PRIMARY KEY,
    student_id          VARCHAR2(50),
    academic_year       VARCHAR2(100),
    academic_grade      VARCHAR2(100),
    academic_school     VARCHAR2(1000),
    average_score       VARCHAR2(50),
    result              VARCHAR2(100),
    is_course_completed NUMBER(1,0) DEFAULT 0, -- Using NUMBER(1,0) for boolean (1 for true, 0 for false)
    tshirt_size         VARCHAR2(100),
    course_id           VARCHAR2(50),
    center_id           VARCHAR2(50),
    CREATED_BY          VARCHAR2(36) NOT NULL,
    UPDATED_BY          VARCHAR2(36) NOT NULL,
    DELETED_BY          VARCHAR2(36) DEFAULT NULL
  );
CREATE TABLE tar_course
  (
    ID          VARCHAR2(36) DEFAULT SYS_GUID() PRIMARY KEY,
    name        VARCHAR2(100) UNIQUE,
    base_course NUMBER(1,0) DEFAULT 1,
    is_active   NUMBER(1,0) ,
    CREATED_BY  VARCHAR2(36) NOT NULL,
    UPDATED_BY  VARCHAR2(36) NOT NULL,
    DELETED_BY  VARCHAR2(36) DEFAULT NULL
  );
  

create table tar_location_coordinator (
  ID          VARCHAR2(36) DEFAULT SYS_GUID() PRIMARY KEY,
		is_primary NUMBER(1,0) DEFAULT 0,
    	location_id varchar2(40), 
    	 user_id    VARCHAR2(40),
     CREATED_BY  VARCHAR2(36) NOT NULL,
    UPDATED_BY  VARCHAR2(36) NOT NULL,
    DELETED_BY  VARCHAR2(36) DEFAULT NULL
);
