The ALTER command is used to modify existing database objects (like tables, columns, constraints, databases, schemas, etc.) without having to drop and recreate them.

🔹 General Syntax
ALTER object_type object_name action;

object_type → TABLE, DATABASE, SCHEMA, USER, ROLE, SEQUENCE, etc.

object_name → The name of the object you want to modify.

action → The modification you want to apply.

1. ALTER TABLE

The most common use of ALTER is with tables.

📌 Add a Column
ALTER TABLE employees ADD COLUMN salary NUMERIC(10,2);

✅ Adds a new column salary.

📌 Drop a Column
ALTER TABLE employees DROP COLUMN salary;

✅ Removes the salary column.

📌 Rename a Column
ALTER TABLE employees RENAME COLUMN salary TO monthly_salary;

✅ Renames the column.

📌 Change Data Type
ALTER TABLE employees ALTER COLUMN monthly_salary TYPE INTEGER;

✅ Changes the column type.

📌 Set Default Value
ALTER TABLE employees ALTER COLUMN monthly_salary SET DEFAULT 3000;

✅ Sets a default value for new rows.

📌 Remove Default Value
ALTER TABLE employees ALTER COLUMN monthly_salary DROP DEFAULT;

📌 Add Constraint
ALTER TABLE employees
ADD CONSTRAINT salary_positive CHECK (monthly_salary > 0);

✅ Adds a constraint.

📌 Drop Constraint
ALTER TABLE employees DROP CONSTRAINT salary_positive;

📌 Rename Table
ALTER TABLE employees RENAME TO staff;

✅ Changes table name.

2. ALTER DATABASE
   📌 Change Database Name
   ALTER DATABASE mydb RENAME TO newdb;

📌 Change Owner
ALTER DATABASE newdb OWNER TO new_owner;

3. ALTER SCHEMA
   ALTER SCHEMA old_schema RENAME TO new_schema;

4. ALTER SEQUENCE
   ALTER SEQUENCE emp_id_seq RESTART WITH 1000;

5. ALTER ROLE / USER
   📌 Change Password
   ALTER ROLE john WITH PASSWORD 'new_password';

📌 Add/Remove Login Privilege
ALTER ROLE john LOGIN;
ALTER ROLE john NOLOGIN;

✅ Example Walkthrough

Suppose we have this table:

CREATE TABLE employees (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
department VARCHAR(50)
);

Now we alter it step by step:

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

👉 So ALTER is your tool for evolving your database schema safely over time.

Perfect 👍 — SELECT is the heart of SQL.
It’s what you’ll use to query and retrieve data from PostgreSQL. Let’s go step by step.

🔹 Basic Syntax
SELECT [DISTINCT | ALL] column_list
FROM table_name
[WHERE condition]
[GROUP BY grouping_columns]
[HAVING group_condition]
[ORDER BY column_list [ASC|DESC]]
[LIMIT count] [OFFSET start];

🔹 Clauses in SELECT

1. SELECT

Choose which columns to return.

SELECT id, name FROM employees;
SELECT \* FROM employees; -- all columns

2. DISTINCT

Removes duplicate rows.

SELECT DISTINCT department FROM employees;

3. WHERE

Filters rows based on conditions.

SELECT _ FROM employees WHERE department = 'HR';
SELECT _ FROM employees WHERE salary > 5000 AND department = 'IT';

4. ORDER BY

Sorts results.

SELECT _ FROM employees ORDER BY salary DESC;
SELECT _ FROM employees ORDER BY department ASC, salary DESC;

5. LIMIT / OFFSET

Restricts number of rows returned.

SELECT _ FROM employees LIMIT 5; -- first 5 rows
SELECT _ FROM employees OFFSET 5; -- skip first 5
SELECT \* FROM employees LIMIT 5 OFFSET 10; -- rows 11–15

6. GROUP BY

Groups rows and is used with aggregate functions (COUNT, SUM, AVG, etc.).

SELECT department, COUNT(\*) AS total_employees
FROM employees
GROUP BY department;

7. HAVING

Filters groups (works like WHERE but after grouping).

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 6000;

8. Aliases

Rename columns or tables for readability.

SELECT name AS employee_name, salary AS monthly_salary
FROM employees e;

9. JOINs

Combine rows from multiple tables.

Example with departments table:

SELECT e.name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;

✅ Full Example

Suppose we have a table:

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

Now a complex query using all major clauses:

SELECT department, COUNT(_) AS total_employees, AVG(salary) AS avg_salary
FROM employees
WHERE salary > 4500
GROUP BY department
HAVING COUNT(_) >= 2
ORDER BY avg_salary DESC
LIMIT 2 OFFSET 0;

🔍 Breakdown:

WHERE salary > 4500 → filter rows first.

GROUP BY department → group by department.

COUNT(\*) + AVG(salary) → calculate group stats.

HAVING COUNT(\*) >= 2 → only groups with at least 2 employees.

ORDER BY avg_salary DESC → sort by average salary.

LIMIT 2 → only top 2 departments.

👉 This is the power flow of SELECT:
FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT/OFFSET

<br><br>

Good one 👍 — let’s cover comparison operators, BETWEEN, and IN in PostgreSQL. These are mostly used inside WHERE clauses for filtering data.

🔹 1. Comparison Operators
Operator Meaning Example
= Equal salary = 5000
<> or != Not equal salary <> 5000

>     Greater than	salary > 5000
>
> < Less than salary < 5000
> = Greater or equal salary >= 5000
> <= Less or equal salary <= 5000

📌 Example:

SELECT \* FROM employees WHERE salary > 6000;

✅ Returns employees with salary greater than 6000.

🔹 2. BETWEEN

BETWEEN checks if a value falls within a range (inclusive of boundaries).
Equivalent to value >= low AND value <= high.

Syntax
expression BETWEEN low AND high

Example
SELECT \* FROM employees WHERE salary BETWEEN 4000 AND 7000;

✅ Returns employees with salary from 4000 to 7000 inclusive.

📌 For NOT:

SELECT \* FROM employees WHERE salary NOT BETWEEN 4000 AND 7000;

🔹 3. IN

IN checks if a value matches any value in a list.
Equivalent to multiple OR conditions.

Syntax
expression IN (value1, value2, value3, ...)

Example
SELECT \* FROM employees WHERE department IN ('HR', 'Finance');

✅ Returns employees only in HR or Finance.

📌 For NOT:

SELECT \* FROM employees WHERE department NOT IN ('IT', 'HR');

✅ Example with Data

Employees table:

INSERT INTO employees (name, department, salary) VALUES
('Alice', 'HR', 5000),
('Bob', 'IT', 7000),
('Charlie', 'IT', 6500),
('Diana', 'Finance', 8000),
('Eve', 'HR', 4000);

Queries:
-- Comparison
SELECT name, salary FROM employees WHERE salary > 6000;

-- BETWEEN
SELECT name, salary FROM employees WHERE salary BETWEEN 4000 AND 7000;

-- IN
SELECT name, department FROM employees WHERE department IN ('HR', 'Finance');

Results:

Comparison → Bob (7000), Charlie (6500), Diana (8000)

BETWEEN → Alice (5000), Bob (7000), Charlie (6500), Eve (4000)

IN → Alice (HR), Eve (HR), Diana (Finance)

👉 Rule of thumb:

Use Comparison for exact or single checks.

Use BETWEEN for ranges.

Use IN for multiple discrete values.

Do you want me to also show you how these work with dates (like BETWEEN '2025-01-01' AND '2025-12-31')? That’s a very common real-world use.<br><br>

<br><br>
<br>

Great question 👍 — LIKE and ILIKE are both used for pattern matching in PostgreSQL, but the difference lies in case sensitivity.

🔹 1. LIKE

Case-sensitive pattern matching.

Uses wildcards:

% → matches zero or more characters

\_ → matches exactly one character

Example:
SELECT name FROM employees WHERE name LIKE 'A%';

✅ Finds names starting with A (e.g., Alice).
🚫 Will NOT match alice (lowercase), because it’s case-sensitive.

🔹 2. ILIKE

Case-insensitive pattern matching.

Same wildcards (% and \_).

Example:
SELECT name FROM employees WHERE name ILIKE 'a%';

✅ Matches Alice and alice.

🔹 Example Data
INSERT INTO employees (name) VALUES
('Alice'),
('alice'),
('ALBERT'),
('Bob'),
('charlie');

Queries & Results:
-- LIKE (case-sensitive)
SELECT name FROM employees WHERE name LIKE 'a%';
-- Result: alice ✅
-- (Only lowercase "a")

-- ILIKE (case-insensitive)
SELECT name FROM employees WHERE name ILIKE 'a%';
-- Result: Alice, alice, ALBERT ✅
-- (Matches regardless of case)

🔹 Summary
Operator Case Sensitivity Example
LIKE Case-sensitive 'Alice' LIKE 'a%' → false
ILIKE Case-insensitive 'Alice' ILIKE 'a%' → true

👉 Think of it like this:

Use LIKE when you care about exact case.

Use ILIKE when you want a case-insensitive search (super useful for user input searches).

Do you want me to also show you how to use LIKE / ILIKE with wildcards in the middle (like %ar%, _a_)? That’s where they get really powerful.

You said:
NOT & Scalar Functions
ChatGPT said:

Perfect 👍 — let’s dig into NOT (logical operator) and Scalar Functions (functions that operate on single values and return a single value).

🔹 1. NOT

A logical operator that negates a condition.

Often used with =, IN, BETWEEN, LIKE, etc.

NOT condition

Examples
-- Not equal
SELECT \* FROM employees WHERE NOT (department = 'HR');

-- NOT IN
SELECT \* FROM employees WHERE department NOT IN ('HR', 'IT');

-- NOT BETWEEN
SELECT \* FROM employees WHERE salary NOT BETWEEN 4000 AND 7000;

-- NOT LIKE
SELECT \* FROM employees WHERE name NOT LIKE 'A%';

✅ Basically, NOT flips true → false, false → true.

🔹 2. Scalar Functions

Scalar functions operate on a single row/column value and return one value.
They don’t work on groups (that’s aggregate functions).

✨ Common Scalar Functions in PostgreSQL
🔸 String Functions
UPPER('alice') -- 'ALICE'
LOWER('ALICE') -- 'alice'
LENGTH('Alice') -- 5
CONCAT('Post', 'gres') -- 'Postgres'
SUBSTRING('Postgres' FROM 1 FOR 4) -- 'Post'
TRIM(' hello ') -- 'hello'

🔸 Numeric Functions
ABS(-10) -- 10
CEIL(7.2) -- 8
FLOOR(7.8) -- 7
ROUND(7.56,1) -- 7.6
POWER(2,3) -- 8
SQRT(16) -- 4

🔸 Date/Time Functions
CURRENT_DATE -- today's date
CURRENT_TIME -- current time
CURRENT_TIMESTAMP -- date + time
AGE('2025-09-07','2000-01-01') -- interval (25 years etc.)
EXTRACT(YEAR FROM CURRENT_DATE) -- 2025

🔸 Conditional Function
COALESCE(NULL, 'Default') -- 'Default' (returns first non-null)
NULLIF(10,10) -- NULL (returns null if equal, else first value)

✅ Example with Data
CREATE TABLE employees (
id SERIAL PRIMARY KEY,
name VARCHAR(50),
department VARCHAR(50),
salary NUMERIC
);

INSERT INTO employees (name, department, salary) VALUES
('Alice', 'HR', 5000),
('Bob', 'IT', 7000),
('Charlie', 'Finance', 8000),
('Diana', 'HR', NULL);

Queries:
-- Using NOT
SELECT name, salary FROM employees WHERE NOT (salary > 6000);

-- Using scalar functions
SELECT
UPPER(name) AS upper_name,
LENGTH(name) AS name_length,
COALESCE(salary, 0) AS safe_salary
FROM employees;

Results:

NOT query → Alice (5000), Diana (NULL not > 6000)

Scalar query

Alice → ALICE, length 5, salary 5000

Bob → BOB, length 3, salary 7000

Charlie → CHARLIE, length 7, salary 8000

Diana → DIANA, length 5, salary 0 (because NULL replaced)

👉 Quick rule:

Use NOT to negate conditions in WHERE.

Use Scalar Functions to transform or compute values per row.

<br>

<br>

🔹 What Are Aggregate Functions?

They perform a calculation on a set of values and return a single value.

Often used with GROUP BY.

Common in reports, statistics, and analytics.

🔹 Common Aggregate Functions in PostgreSQL

1. COUNT()

Counts rows.

SELECT COUNT(\*) FROM employees; -- all rows
SELECT COUNT(salary) FROM employees; -- non-null salaries

2. SUM()

Adds values.

SELECT SUM(salary) AS total_salary FROM employees;

3. AVG()

Finds the average.

SELECT AVG(salary) AS avg_salary FROM employees;

4. MIN() / MAX()

Finds smallest/largest.

SELECT MIN(salary) AS lowest, MAX(salary) AS highest FROM employees;

5. STRING_AGG()

Concatenates strings with a separator.

SELECT STRING_AGG(name, ', ') AS all_names FROM employees;

6. ARRAY_AGG()

Collects values into an array.

SELECT ARRAY_AGG(name) AS name_list FROM employees;

🔹 Using Aggregate Functions with GROUP BY

Suppose we have:

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

Query with grouping:
SELECT department,
COUNT(\*) AS total_employees,
SUM(salary) AS total_salary,
AVG(salary) AS avg_salary,
MAX(salary) AS highest_salary,
MIN(salary) AS lowest_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

Result:
department total_employees total_salary avg_salary highest_salary lowest_salary
Finance 1 8000 8000 8000 8000
IT 2 13500 6750 7000 6500
HR 2 9000 4500 5000 4000
🔹 HAVING with Aggregates

HAVING filters after grouping (whereas WHERE filters before grouping).

Example:

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 5000;

✅ Only IT and Finance departments will appear.

🔹 Execution Flow (very important)

Order of execution in a SELECT with aggregates:

FROM (get table)

WHERE (filter rows)

GROUP BY (make groups)

HAVING (filter groups)

SELECT (apply aggregates)

ORDER BY

LIMIT/OFFSET

👉 Quick difference reminder:

Scalar functions → operate per row.

Aggregate functions → operate across rows (collapse into one).

Would you like me to also include a side-by-side table comparing Scalar vs Aggregate functions with examples? That would make the difference crystal clear.

You said:
yes
ChatGPT said:

Perfect 👍 — let’s make a clear side-by-side comparison of Scalar vs Aggregate Functions in PostgreSQL.

🔹 Scalar vs Aggregate Functions
Feature Scalar Functions Aggregate Functions
Definition Operate on a single value and return a single value Operate on a set of values (multiple rows) and return a single summarized value
Scope Row by row Across rows / groups
Grouping needed? No Often used with GROUP BY
Examples UPPER(), LOWER(), LENGTH(), ABS(), ROUND() COUNT(), SUM(), AVG(), MIN(), MAX()
NULL handling Applied to each row, may return NULL Most ignore NULLs (except COUNT(\*))
Use case Transform or compute values Summarize or aggregate data
🔹 Example Table
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

🔹 Scalar Function Example
SELECT name, UPPER(name) AS upper_name, LENGTH(name) AS name_length
FROM employees;

✅ Result (row by row):

name upper_name name_length
Alice ALICE 5
Bob BOB 3
Charlie CHARLIE 7
Diana DIANA 5
Eve EVE 3
🔹 Aggregate Function Example
SELECT department,
COUNT(\*) AS total_employees,
AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

✅ Result (collapsed by department):

department total_employees avg_salary
HR 2 4500
IT 2 6750
Finance 1 8000
🔹 Key Takeaway

Scalar = per row transformation

Aggregate = group or table summary
