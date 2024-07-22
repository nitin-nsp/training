create table address (
	id uuid not null primary key , 
	address TEXT,
	aptSuite character varying (100),
	longitude FLOAT(7),
	latitude FLOAT(7),
	city character varying (100),
	country character varying (100),
	state character varying (100),
	zipCode character varying (100),
	created_by uuid not null,
	updated_by uuid not null,
	deleted_by uuid
);

CREATE TABLE users
(
    id uuid NOT NULL,
    first_name character varying(100) COLLATE pg_catalog."default",
    last_name character varying(100) COLLATE pg_catalog."default",
    middle_name character varying(100) COLLATE pg_catalog."default",
    gender character varying(1) COLLATE pg_catalog."default",
    is_active boolean,
	CONTACT_NUMBER CHARACTER VARYING (50),
    manabadi_email character varying(100) COLLATE pg_catalog."default",
    personal_email character varying(100) COLLATE pg_catalog."default",
    address_id uuid not null,
    created_by uuid not null,
    updated_by uuid not null,
    deleted_by uuid
);

 create table region (
	id uuid not null primary key , 
	name character varying (100),
	description character varying (200),
	created_by uuid not null,
	updated_by uuid not null,
	deleted_by uuid
);


create table region_coordinator (
	  id uuid not null primary Key, 
	  is_primary BOOLEAN DEFAULT FALSE,
      region_id uuid not null,
	  user_id uuid not null,
	  created_by uuid not null,
	  updated_by uuid not null,
	  deleted_by uuid
);

create table location (
    	id uuid not null primary key , 
        name character varying (100),
		is_active BOOLEAN not null,
		is_default BOOLEAN not null,
        start_time TIME,
        end_time TIME,
        class_timing TIME,
        region_id uuid not null,
        address_id uuid not null,
	    description character varying (200),
	    created_by uuid not null,
	    updated_by uuid not null,
	    deleted_by uuid
);


create table location_coordinator (
	    id uuid not null PRIMARY key, 
		is_primary BOOLEAN not null DEFAULT FALSE,
    	location_id uuid, 
    	user_id uuid , 
    	created_by uuid,
    	updated_by uuid,
    	deleted_by uuid
);


create table exam_center (
	  id uuid not null primary key , 
	  name character varying (100) not null,
	  is_active BOOLEAN ,
      address_id uuid ,
	  location_id uuid ,
	  created_by uuid ,
	  updated_by uuid ,
	  deleted_by uuid
);





create table course (
	    id uuid not null primary key , 
	    name character varying (100) unique,
	    base_course BOOLEAN DEFAULT TRUE,
    	is_active BOOLEAN ,
    	created_by uuid ,
	    updated_by uuid ,
	    deleted_by uuid
);


create table enrolled_course (
	  id uuid not null primary Key, 
	  student_id CHARACTER VARYING (50), ,
      academic_year character varying (100),	
      academic_grade character varying (100),
      academic_school TEXT ,
      average_score CHARACTER VARYING (50),,
      result character varying (100),
      is_course_completed BOOLEAN DEFAULT FALSE,
      tshirt_size character varying (100),
      course_id CHARACTER VARYING (50),
      center_id CHARACTER VARYING (50),
	  created_by uuid not null ,
	  updated_by uuid not null,
	  deleted_by uuid
);

