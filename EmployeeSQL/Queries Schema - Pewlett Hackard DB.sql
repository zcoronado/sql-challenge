--Pewlett Hackard DB Queries Schema

Drop Table IF Exists departments; 

 CREATE TABLE "departments" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

Drop Table IF Exists titles; 

CREATE TABLE "titles" (
    "title_id" VARCHAR(255)   NOT NULL,
    "title" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

Drop Table IF Exists employees; 

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(255)   NOT NULL,
    "birth_date" VARCHAR(10)   NOT NULL,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" VARCHAR(10)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

Drop Table IF Exists dept_emp; 

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(255)   NOT NULL
);


Drop Table IF Exists dept_manager;

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "emp_no" INT   NOT NULL
);

Drop Table IF Exists salaries;

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


-- Select * from departments ; 
-- Select * from titles ; 
-- Select * from employees ; 
-- Select * from dept_emp ; 
-- Select * from dept_manager ; 
-- Select * from salaries ; 

-- 1) List the following details of each employee: employee number, last name, first name, sex, and salary.

Select 
	e.emp_no
	, e.last_name
	, e.first_name
	, e.sex
	, s.salary
From 
	employees e 
	Join salaries s on e.emp_no = s.emp_no ; 

-- 2)List first name, last name, and hire date for employees who were hired in 1986.

Select 
	e.last_name
	, e.first_name
	, e.hire_date

From 
	employees e 
Where 1=1
	AND hire_date ilike '%1986%' ; 
	
-- 3)List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.

Select 
	dm.dept_no
	, dm.emp_no
	, d.dept_name
	, e.last_name
	, e.first_name
From 
	dept_manager dm 
	Join departments d on d.dept_no = dm.dept_no 
	Join employees e on e.emp_no = dm.emp_no ; 

-- 4) List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

Select 
	e.emp_no
	, e.last_name
	, e.first_name
	, d.dept_name
From 
	employees e 
	Join dept_emp de on de.emp_no = e.emp_no
	Join departments d on d.dept_no = de.dept_no ;

-- 5) List first name, last name, and sex 
-- for employees whose first name is "Hercules" and last names begin with "B."

Select 
	e.first_name
	, e.last_name
	, e.sex
From employees e 
Where e.first_name = 'Hercules'
And e.last_name ilike 'B%' ; 

-- 6) List all employees in the Sales department, 
-- including their employee number, last name, first name, and department name.

Select
	e.emp_no
	, e.last_name
	, e.first_name
	, d.dept_name
From 
	employees e 
	Join dept_emp de on de.emp_no = e.emp_no
	Join departments d on d.dept_no = de.dept_no 
Where d.dept_name = 'Sales' ; 

-- 7) List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.

Select
	e.emp_no
	, e.last_name
	, e.first_name
	, d.dept_name
From 
	employees e 
	Join dept_emp de on de.emp_no = e.emp_no
	Join departments d on d.dept_no = de.dept_no 
Where d.dept_name in ('Sales', 'Development'); 

-- 8) In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

Select 
	last_name
	, count(last_name)
From 
	employees 
	group by 1 
	order by count desc ; 

