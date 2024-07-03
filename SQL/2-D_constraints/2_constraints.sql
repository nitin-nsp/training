/* constraints*/
create DATABASE tr;

-- show dbs
SELECT
    name,
    database_id,
    create_date
FROM
    sys.databases;

GO
    use tr;

create table students(
    student_id int,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    CONSTRAINT st_id_pk PRIMARY key (student_id)
) create table courses(
    courses_id int,
    course_name varchar(20),
    instructor VARCHAR(20),
    CONSTRAINT uq_cr_id UNIQUE(courses_id),
    -- CONSTRAINT not_null_course_name  Not NULL(course_name)
)
alter table
    students
add
    date_of_birth date not null;

SELECT
    constraint_name,
    constraint_type
FROM
    information_schema.table_constraints
WHERE
    table_name = 'Employees';

/*2-d */
CREATE TABLE Employees(
    EmployeesId int,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    CONSTRAINT eId_pk PRIMARY key(EmployeesId)
);

-- ALTER TABLE MY_EMPLOYEE
-- ALTER column last_name VARCHAR(200)
-- alter TABLE Employees add CONSTRAINT not_null_fname not null  FirstName;
alter TABLE
    Employees
add
    CONSTRAINT gt_z check(EmployeesId > 0);

--4
create TABLE Departments(
    DepartmentID int PRIMARY key,
    DepartmentName VARCHAR(50) not null
) drop table Departments;

alter TABLE
    Departments
add
    CONSTRAINT id_pk PRIMARY key(DepartmentID);

--error
/*Msg 8111, Level 16, State 1, Line 1
 Cannot define PRIMARY KEY constraint on nullable column in table 'Departments'.*/
--5
alter TABLE
    Departments
add
    CONSTRAINT uq_name UNIQUE(DepartmentName);

--6
create table Projects(
    ProjectId int PRIMARY key,
    ProjectName VARCHAR(50) not null,
    DepartmentId int,
    FOREIGN key (DepartmentId) REFERENCES Departments(DepartmentID)
) --7
alter TABLE
    Projects
add
    CONSTRAINT ch_len check (len(ProjectName) > 0) --8
    create table Salaries(
        SalaryID int PRIMARY key,
        EmployeeID int,
        Amount DECIMAL not null,
        FOREIGN key (EmployeeID) REFERENCES Employees(EmployeesId)
    ) --9
alter table
    Salaries
add
    CONSTRAINT am_ch check(Amount > 0) --10
alter TABLE
    Salaries
add
    CONSTRAINT df_am DEFAULT 50000 for Amount;

-- medium
--1
create table Timesheets(
    TimesheetID int PRIMARY key,
    EmployeeID int,
    FOREIGN key (EmployeeID) REFERENCES Employees(EmployeesId),
    Date date not null,
    HoursWorked DECIMAL not null,
    CONSTRAINT not_future check(Date <= getdate())
) --2
ALTER TABLE
    Timesheets
add
    CONSTRAINT hr_worked check(
        HoursWorked >= 0
        and HoursWorked < 24
    );

--3
CREATE TABLE EmployeeProjects(
    EmployeeID int,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeesId),
    ProjectID int,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectId)
) -- 4
ALTER TABLE
    Departments
add
    CONSTRAINT not_str_deptName check(DepartmentName not LIKE '%[0-9]%') --5
    CREATE TABLE Leaves(
        LeaveID int PRIMARY KEY,
        EmployeeID int,
        FOREIGN key (EmployeeID) REFERENCES Employees(EmployeesId),
        StartDate Date not null,
        EndDate date not null,
        CONSTRAINT end_gt_st CHECK(StartDate < EndDate)
    ) --6
ALTER TABLE
    Leaves
add
    CONSTRAINT df_stDate DEFAULT GETDATE() for StartDate;

/* Hard*/
--1
create TABLE Reviews(
    ReviewID int PRIMARY key,
    EmployeeID int,
    FOREIGN key (EmployeeID) REFERENCES Employees(EmployeesId),
    ReviewerID int,
    FOREIGN key (ReviewerID) REFERENCES Employees(EmployeesId),
    ReviewDate date not null,
    Score int not null,
    CONSTRAINT same_reviewer CHECK(EmployeeID != ReviewerID)
) --2
ALTER TABLE
    Reviews
add
    CONSTRAINT out_rng CHECK(
        Score >= 1
        and Score <= 5
    );

--3
CREATE TABLE Assests(
    AssetID int PRIMARY key,
    AssetName varchar(50) not null,
    PurchaseDate date not null,
    EmployeeID int,
    FOREIGN key (EmployeeID) REFERENCES Employees(EmployeesId),
    CONSTRAINT not_correctDate CHECK(PurchaseDate > getdate())
) --4
-- CREATE TABLE Budgets(
--     BudgetID int PRIMARY key,
--     DepartmentID int,
--     FOREIGN key (DepartmentID) REFERENCES Departments(DepartmentID),
--     YEAR int not null,
--     Amount DECIMAL not NULL,
--     constraint cant_give_extraBudgetIN_year check( select count(distinct DepartmentID) from Budgets group by Year <=1)
-- )
CREATE TABLE Budgets(
    BudgetID int PRIMARY key,
    DepartmentID int,
    FOREIGN key (DepartmentID) REFERENCES Departments(DepartmentID),
    [Year] int not null,
    Amount DECIMAL not NULL,
    constraint unique_budget_per_department_per_year UNIQUE (DepartmentID, Year)
);