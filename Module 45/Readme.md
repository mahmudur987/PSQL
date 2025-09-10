# PostgreSQL Learning Notes

This document contains a detailed explanation of important PostgreSQL commands and concepts with examples.

---

## 🔹 ALTER Command

The `ALTER` command is used to modify existing database objects (like tables, columns, constraints, databases, schemas, etc.) without having to drop and recreate them.

### General Syntax

```sql
ALTER object_type object_name action;
<br><br>


object_type → TABLE, DATABASE, SCHEMA, USER, ROLE, SEQUENCE, etc.

object_name → The name of the object you want to modify.

action → The modification you want to apply.


<br><br>


-- Add a Column
ALTER TABLE employees ADD COLUMN salary NUMERIC(10,2);

-- Drop a Column
ALTER TABLE employees DROP COLUMN salary;

-- Rename a Column
ALTER TABLE employees RENAME COLUMN salary TO monthly_salary;

-- Change Data Type
ALTER TABLE employees ALTER COLUMN monthly_salary TYPE INTEGER;

-- Set Default Value
ALTER TABLE employees ALTER COLUMN monthly_salary SET DEFAULT 3000;

-- Remove Default Value
ALTER TABLE employees ALTER COLUMN monthly_salary DROP DEFAULT;

-- Add Constraint
ALTER TABLE employees
ADD CONSTRAINT salary_positive CHECK (monthly_salary > 0);

-- Drop Constraint
ALTER TABLE employees DROP CONSTRAINT salary_positive;

-- Rename Table
ALTER TABLE employees RENAME TO staff;



<br>




2. ALTER DATABASE


-- Change Database Name
ALTER DATABASE mydb RENAME TO newdb;

-- Change Owner
ALTER DATABASE newdb OWNER TO new_owner;



3. ALTER SCHEMA
ALTER SCHEMA old_schema RENAME TO new_schema;



4. ALTER SEQUENCE

ALTER SEQUENCE emp_id_seq RESTART WITH 1000;

<br>
5. ALTER ROLE / USER

-- Change Password
ALTER ROLE john WITH PASSWORD 'new_password';

-- Add/Remove Login Privilege
ALTER ROLE john LOGIN;
ALTER ROLE john NOLOGIN;




✅ Example Walkthrough

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50)
);

-- Add a column
ALTER TABLE employees ADD COLUMN salary NUMERIC(10,2);

-- Rename column
ALTER TABLE employees RENAME COLUMN department TO dept;

-- Change data type
ALTER TABLE employees ALTER COLUMN salary TYPE INTEGER;

-- Add a default
ALTER TABLE employees ALTER COLUMN salary SET DEFAULT 3000;

-- Add a check constraint
ALTER TABLE employees ADD CONSTRAINT positive_salary CHECK (salary > 0);
<br>
🔹 SELECT Command

The SELECT command is the heart of SQL. It’s used to query and retrieve data.

Basic Syntax

SELECT [DISTINCT | ALL] column_list
FROM table_name
[WHERE condition]
[GROUP BY grouping_columns]
[HAVING group_condition]
[ORDER BY column_list [ASC|DESC]]
[LIMIT count] [OFFSET start];






<br><br>
SELECT [DISTINCT | ALL] column_list
FROM table_name
[WHERE condition]
[GROUP BY grouping_columns]
[HAVING group_condition]
[ORDER BY column_list [ASC|DESC]]
[LIMIT count] [OFFSET start];
<br><br><br><br>





SELECT

SELECT id, name FROM employees;
SELECT * FROM employees; -- all columns


DISTINCT

SELECT DISTINCT department FROM employees;


WHERE

SELECT * FROM employees WHERE department = 'HR';
SELECT * FROM employees WHERE salary > 5000 AND department = 'IT';


ORDER BY

SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY department ASC, salary DESC;


LIMIT / OFFSET

SELECT * FROM employees LIMIT 5;       -- first 5 rows
SELECT * FROM employees OFFSET 5;      -- skip first 5
SELECT * FROM employees LIMIT 5 OFFSET 10; -- rows 11–15


GROUP BY

SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department;


HAVING

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 6000;


Aliases

SELECT name AS employee_name, salary AS monthly_salary
FROM employees e;


JOINs

SELECT e.name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;

✅ Full Example
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary NUMERIC
);

INSERT INTO employees (name, department, salary) VALUES
('Alice', 'HR', 5000),
('Bob', 'IT', 7000),
('Charlie', 'IT', 6500),
('Diana', 'Finance', 8000),
('Eve', 'HR', 4000);

SELECT department, COUNT(*) AS total_employees, AVG(salary) AS avg_salary
FROM employees
WHERE salary > 4500
GROUP BY department
HAVING COUNT(*) >= 2
ORDER BY avg_salary DESC
LIMIT 2 OFFSET 0;


👉 Execution flow:
FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT/OFFSET<br>







🔹 Comparison, BETWEEN, IN
1. Comparison Operators
Operator	Meaning	Example
=	Equal	salary = 5000
<> or !=	Not equal	salary <> 5000
>	Greater than	salary > 5000
<	Less than	salary < 5000
>=	Greater or equal	salary >= 5000
<=	Less or equal	salary <= 5000
2. BETWEEN
SELECT * FROM employees WHERE salary BETWEEN 4000 AND 7000;
SELECT * FROM employees WHERE salary NOT BETWEEN 4000 AND 7000;

3. IN
SELECT * FROM employees WHERE department IN ('HR', 'Finance');
SELECT * FROM employees WHERE department NOT IN ('IT', 'HR');

✅ Example with Data
INSERT INTO employees (name, department, salary) VALUES
('Alice', 'HR', 5000),
('Bob', 'IT', 7000),
('Charlie', 'IT', 6500),
('Diana', 'Finance', 8000),
('Eve', 'HR', 4000);

🔹 LIKE vs ILIKE
LIKE (Case-sensitive)
SELECT name FROM employees WHERE name LIKE 'A%';

ILIKE (Case-insensitive)
SELECT name FROM employees WHERE name ILIKE 'a%';

Example Data
INSERT INTO employees (name) VALUES
('Alice'),
('alice'),
('ALBERT'),
('Bob'),
('charlie');

✅ Summary
Operator	Case Sensitivity	Example
LIKE	Case-sensitive	'Alice' LIKE 'a%' → false
ILIKE	Case-insensitive	'Alice' ILIKE 'a%' → true
🔹 NOT & Scalar Functions
1. NOT Operator
SELECT * FROM employees WHERE NOT (department = 'HR');
SELECT * FROM employees WHERE department NOT IN ('HR', 'IT');
SELECT * FROM employees WHERE salary NOT BETWEEN 4000 AND 7000;
SELECT * FROM employees WHERE name NOT LIKE 'A%';

2. Scalar Functions
String Functions
UPPER('alice')         -- 'ALICE'
LOWER('ALICE')         -- 'alice'
LENGTH('Alice')        -- 5
CONCAT('Post','gres')  -- 'Postgres'
SUBSTRING('Postgres' FROM 1 FOR 4) -- 'Post'
TRIM(' hello ')        -- 'hello'

Numeric Functions
ABS(-10)      -- 10
CEIL(7.2)     -- 8
FLOOR(7.8)    -- 7
ROUND(7.56,1) -- 7.6
POWER(2,3)    -- 8
SQRT(16)      -- 4

Date/Time Functions
CURRENT_DATE
CURRENT_TIME
CURRENT_TIMESTAMP
AGE('2025-09-07','2000-01-01')
EXTRACT(YEAR FROM CURRENT_DATE)

Conditional Functions
COALESCE(NULL, 'Default') -- 'Default'
NULLIF(10,10)             -- NULL

🔹 Aggregate Functions

Aggregate functions summarize data across rows.

Common Functions
COUNT(*)
SUM(salary)
AVG(salary)
MIN(salary)
MAX(salary)
STRING_AGG(name, ', ')
ARRAY_AGG(name)

Example with GROUP BY
SELECT department,
       COUNT(*) AS total_employees,
       SUM(salary) AS total_salary,
       AVG(salary) AS avg_salary,
       MAX(salary) AS highest_salary,
       MIN(salary) AS lowest_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

✅ Execution Flow

FROM

WHERE

GROUP BY

HAVING

SELECT

ORDER BY

LIMIT/OFFSET

🔹 Scalar vs Aggregate Functions
Feature	Scalar Functions	Aggregate Functions
Definition	Operate on a single value	Operate on a set of values
Scope	Row by row	Across rows/groups
Grouping?	No	Often used with GROUP BY
Examples	UPPER(), LENGTH(), ABS()	COUNT(), SUM(), AVG()
NULL handling	May return NULL	Ignores NULLs (except COUNT(*))
Use case	Transform values	Summarize data
✅ Scalar Example
SELECT name, UPPER(name) AS upper_name, LENGTH(name) AS name_length
FROM employees;

✅ Aggregate Example
SELECT department,
       COUNT(*) AS total_employees,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

📌 Key Takeaway

Scalar functions → transform individual row values.

Aggregate functions → summarize multiple rows.
```
