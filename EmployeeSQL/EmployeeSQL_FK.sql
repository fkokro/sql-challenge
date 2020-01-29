---SQL Homework - Employee Database: A Mystery in Two Parts

---CREATE employees TABLE
CREATE TABLE employees(
    emp_no INT PRIMARY KEY NOT NULL,
    birth_date VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    gender VARCHAR(1) NOT NULL,
    hire_date VARCHAR NOT NULL
);

---CREATE departments TABLE
CREATE TABLE departments(
    dept_no VARCHAR(255) PRIMARY KEY NOT NULL,
    dept_name VARCHAR(255) NOT NULL
);

---CREATE employees TABLE
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(255) NOT NULL,
    from_date VARCHAR(255) NOT NULL,
    to_date VARCHAR(255) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

---CREATE dept_manager TABLE
CREATE TABLE dept_manager (
    dept_no VARCHAR(255) NOT NULL,
    emp_no INT NOT NULL,
    from_date VARCHAR(255) NOT NULL,
    to_date VARCHAR(255) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

---CREATE salaries TABLE
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date VARCHAR(255) NOT NULL,
    to_date VARCHAR(255) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

---CREATE titles TABLE
CREATE TABLE titles (
    emp_no INT  NOT NULL,
    title VARCHAR(255)  NOT NULL,
    from_date VARCHAR(255) NOT NULL,
    to_date VARCHAR(255) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


--1.List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary FROM salaries s
INNER JOIN employees e
on 
e.emp_no = s.emp_no;

--2.List employees who were hired in 1986.
select * from employees
where hire_date like '1986%'

--3.List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date FROM dept_manager dm
INNER JOIN employees e
ON
e.emp_no = dm.emp_no
INNER JOIN departments d
ON
d.dept_no = dm.dept_no;

--4.List the department of each employee with the following information: employee number, last name, first name, and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name FROM employees e
INNER JOIN dept_emp de
ON
e.emp_no = de.emp_no
INNER JOIN departments d
ON
de.dept_no = d.dept_no

--5.List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name FROM employees e
INNER JOIN dept_emp de
ON 
e.emp_no = de.emp_no
INNER JOIN departments d
ON
de.dept_no = d.dept_no
WHERE dept_name = 'Sales'

--7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name FROM employees e
INNER JOIN dept_emp de
ON
e.emp_no = de.emp_no
INNER JOIN departments d
ON
de.dept_no = d.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'

--8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS frequency FROM employees
GROUP BY last_name
ORDER BY frequency DESC
