--How to create duplicate table from already existed table with data
Select * into Countries_Duplicate from countries

--How to create duplicate table from already existed table without data
Select * into Countries_Duplicate from countries where 1<>1

-----------------------------------------------------------------------------------------------------------------------------------

--Write a MySQL query to create a table named jobs including columns job_id, job_title, min_salary, max_salary and check whether the max_salary amount exceeding the upper limit 25000.

CREATE TABLE tbl_Jobs
(
	job_id int,
	job_title varchar(1000),
	min_salary int,
	max_salary int CHECK(max_salary < 25000)
)

Insert into tbl_Jobs(job_id,job_title,min_salary,max_salary) values (1001,'S/W Engineer',10000,24999)
Select * from tbl_Jobs

--_________________________________________________________________________________________________________________________________

--Write a MySQL query to create a table named countries including columns country_id, country_name and region_id and make sure that no countries except Italy, India and China will be entered in the table.

CREATE TABLE tbl_Coutries
(
	country_id int,
	country_name varchar(1000),
	region_id int,
	constraint cn_name check( country_name not in ('Italy','India','China'))
)
--INSERT INTO tbl_Coutries values (1001,'China',102)
INSERT INTO tbl_Coutries values (1001,'USA',102)
SELECT * FROM tbl_Coutries

--_________________________________________________________________________________________________________________________________

 --Write a MySQL query to create a table named job_histry including columns employee_id, start_date, end_date, job_id and department_id and make sure that the value against column start_date not less than year 1980.
 --DROP table tbl_Job_history
 --ALTER TABLE tbl_Job_history alter column end_date varchar(10)
 
 CREATE TABLE tbl_Job_history
 (
	employee_id int,
	start_date date,
	end_date varchar(10),
	job_id int,
	department_id int,
	constraint dt_Constraint_Date CHECK(DATEPART(year,start_date) > 1980)
 )
 
 INSERT INTO tbl_Job_history VALUES ('1001',GETDATE(),'1981-07-15',101,101)
 
 Select * from tbl_Job_history 
 
 --________________________________________________________________________________________________________________________________
 
 --Write a MySQL query to create a table named countries including columns country_id,country_name and region_id and make sure that no duplicate data against column country_id will be allowed at the time of insertion.
 
 CREATE TABLE tbl_Countries
 (
	country_id int,
	country_name varchar(100),
	region_id int unique
 )
 INSERT INTO tbl_Countries values (333,'Spain',12)
 INSERT INTO tbl_Countries values (333,'Spain',12)
 
 --________________________________________________________________________________________________________________________________
 
--Write a MySQL query to create a table named jobs including columns job_id, job_title, min_salary and max_salary, and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will be entered automatically at the time of insertion if no value assigned for the specified columns.
  
CREATE TABLE tbl_Jobs_Dup
(
	job_id int,
	job_title varchar(1000) default '',
	min_salary int check(min_salary !< 8000),
	max_salary int default null
)

INSERT INTO tbl_Jobs_Dup VALUES (1520,'',9000,15200)
Select * from tbl_Jobs_Dup


--_________________________________________________________________________________________________________________________________

--Write a MySQL query to create a table named countries including columns country_id, country_name and region_id and make sure that the country_id column will be a key field which will not contain any duplicate data at the time of insertion

CREATE TABLE tbl_Country
(
	country_id int PRIMARY KEY,
	country_name varchar(100),
	region_id int
)

INSERT INTO tbl_Country values (109,'Finland',323)
INSERT INTO tbl_Country values (110,'Nepal',324)
INSERT INTO tbl_Country values (109,'Finland',323)

SELECT * FROM tbl_Country

--_________________________________________________________________________________________________________________________________

--Write a MySQL query to create a table countries including columns country_id, country_name and region_id and make sure that the column country_id will be unique and store an auto incremented value.

CREATE TABLE tbl_Country_AutoINC
(
	country_id bigint PRIMARY KEY IDENTITY(0001,1),
	country_name VARCHAR(1000),
	region_id int
)
INSERT INTO tbl_Country_AutoINC values ('Finland',323)
INSERT INTO tbl_Country_AutoINC values ('Nepal',324)
INSERT INTO tbl_Country_AutoINC values ('Bhutan',325)

SELECT * FROM tbl_Country_AutoINC

--_________________________________________________________________________________________________________________________________

--Write a MySQL query to create a table countries including columns country_id, country_name and region_id and make sure that the combination of columns country_id and region_id will be unique.

CREATE TABLE tbl_Country_Prime
(
	country_id bigint PRIMARY KEY IDENTITY(0001,1),
	country_name VARCHAR(1000),
	region_id int unique
)

INSERT INTO tbl_Country_Prime values ('Finland',323)
INSERT INTO tbl_Country_Prime values ('Nepal',324)
INSERT INTO tbl_Country_Prime values ('Bhutan',324)

SELECT * FROM tbl_Country_Prime

--_________________________________________________________________________________________________________________________________

-- Write a MySQL query to create a table job_history including columns employee_id, start_date, end_date, job_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key column job_id contain only those values which are exists in the jobs table.

CREATE TABLE tbl_Job_History_1
(
	employee_id int primary key identity(1000,1),
	start_date date,
	end_date date default null,
	job_id int default null,
	department_id int,
	constraint fk_jobId foreign key(job_id) references tbl_jobs
)

--_________________________________________________________________________________________________________________________________

--Write a MySQL query to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key columns combined by department_id and manager_id columns contain only those unique combination values, which combinations are exists in the departments table
-- first we need to create department table
CREATE TABLE DEPARTMENT
(
	department_id int IDENTITY,
	department_name varchar(200),
	manager_id int unique,
	location_id int,
	CONSTRAINT PK_DEMA PRIMARY KEY CLUSTERED (department_id,manager_id)
)

--now create emplyoyees table
CREATE TABLE tbl_Employees
(
	employee_id int primary key identity,
	first_name varchar(500),
	last_name varchar(500),
	email varchar(500),
	phone_no varchar(20),
	hire_date date,
	job_id int,
	salary money,
	comission varchar(50),
	manager_id int,
	department_id int,
	CONSTRAINT FK_md FOREIGN KEY(department_id,manager_id) REFERENCES DEPARTMENT(department_id,manager_id)
)
--truncate table department
--truncate table tbl_Employees
INSERT INTO DEPARTMENT VALUES('HR',501,03)
INSERT INTO DEPARTMENT VALUES('EMP',503,04)
INSERT INTO tbl_Employees VALUES('JOHN','Doe','john@email.com','+91 1254878965',GETDATE(),74851,50000,'NA',503,5)
Select * from DEPARTMENT
select * from tbl_Employees


