# Module 45: ALTER, SELECT, Comparison Operators, BETWEEN, IN, LIKE, ILIKE, NOT, Scalar Functions, Aggregate Functions

## ALTER

The ALTER command is used to modify existing database objects (like tables, columns, constraints, databases, schemas, etc.) without having to drop and recreate them.

### General Syntax

ALTER object_type object_name action;

object_type -> TABLE, DATABASE, SCHEMA, USER, ROLE, SEQUENCE, etc.
object_name -> The name of the object you want to modify.
action -> The modification you want to apply.

### Examples

#### Add a Column

ALTER TABLE employees ADD COLUMN salary NUMERIC(10,2);

Adds a new column salary.

#### Drop a Column

ALTER TABLE employees DROP COLUMN salary;

Removes the salary column.

#### Rename a Column

ALTER TABLE employees RENAME COLUMN salary TO monthly_salary;

Renames the column.

#### Change Data Type

ALTER TABLE employees ALTER COLUMN monthly_salary TYPE INTEGER;

Changes the column type.

#### Set Default Value

ALTER TABLE employees ALTER COLUMN monthly_salary SET DEFAULT 3000;

Sets a default value for new rows.

#### Remove Default Value

ALTER TABLE employees ALTER COLUMN monthly_salary DROP DEFAULT;

#### Add Constraint

ALTER TABLE employees
ADD CONSTRAINT salary_positive CHECK (monthly_salary > 0);

Adds a constraint.

#### Drop Constraint

ALTER TABLE employees DROP CONSTRAINT salary_positive;

#### Rename Table

ALTER TABLE employees RENAME TO staff;

Changes table name.

## SELECT

SELECT is the heart of SQL.
It’s what you’ll use to query and retrieve data from PostgreSQL. Let’s go step by step.

### Basic Syntax

SELECT [DISTINCT | ALL] column_list
FROM table_name
[WHERE condition]
[GROUP BY grouping_columns]
[HAVING group_condition]
[ORDER BY column_list [ASC|DESC]]
[LIMIT count] [OFFSET start];

### Clauses in SELECT

#### SELECT

Choose which columns to return.

SELECT id, name FROM employees;
SELECT \* FROM employees; -- all columns

#### DISTINCT

Removes duplicate rows.

SELECT DISTINCT department FROM employees;

#### WHERE

Filters rows based on conditions.

SELECT _ FROM employees WHERE department = 'HR';
SELECT _ FROM employees WHERE salary > 5000 AND department = 'IT';

#### ORDER BY

Sorts results.

SELECT _ FROM employees ORDER BY salary DESC;
SELECT _ FROM employees ORDER BY department ASC, salary DESC;

#### LIMIT / OFFSET

Restricts number of rows returned.

SELECT _ FROM employees LIMIT 5; -- first 5 rows
SELECT _ FROM employees OFFSET 5; -- skip first 5
SELECT \* FROM employees LIMIT 5 OFFSET 10; -- rows 11–15

#### GROUP BY

Groups rows and is used with aggregate functions (COUNT, SUM, AVG, etc.).

SELECT department, COUNT(\*) AS total_employees
FROM employees
GROUP BY department;

#### HAVING

Filters groups (works like WHERE but after grouping).

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 6000;

#### Aliases

Rename columns or tables for readability.

SELECT name AS employee_name, salary AS monthly_salary
FROM employees e;

#### JOINs

Combine rows from multiple tables.

Example with departments table:

SELECT e.name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;

## Comparison Operators, BETWEEN, IN, LIKE, ILIKE, NOT

### Comparison Operators

Operator Meaning Example
= Equal salary = 5000
<> or != Not equal salary <> 5000

>     Greater than	salary > 5000
>
> < Less than salary < 5000
> = Greater or equal salary >= 5000
> <= Less or equal salary <= 5000

### BETWEEN

BETWEEN checks if a value falls within a range (inclusive of boundaries).
Equivalent to value >= low AND value <= high.

Syntax
expression BETWEEN low AND high

Example
SELECT \* FROM employees WHERE salary BETWEEN 4000 AND 7000;

### IN

IN checks if a value matches any value in a list.
Equivalent to multiple OR conditions.

Syntax
expression IN (value1, value2, value3, ...)

Example
SELECT \* FROM employees WHERE department IN ('HR', 'Finance');

### LIKE and ILIKE

LIKE and ILIKE are used for pattern matching in PostgreSQL.

LIKE is case-sensitive.
ILIKE is case-insensitive.

Syntax
string LIKE pattern
string ILIKE pattern

Example
SELECT \* FROM employees WHERE name LIKE 'A%';

### NOT

A logical operator that negates a condition.
Often used with =, IN, BETWEEN, LIKE, etc.

Syntax
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

## Scalar Functions

Scalar functions operate on a single row/column value and return a single value.
They don’t work on groups (that’s aggregate functions).

Common Scalar Functions in PostgreSQL:

- String Functions
  - UPPER('alice') -- 'ALICE'
  - LOWER('ALICE') -- 'alice'
  - LENGTH('Alice') -- 5
  - CONCAT('Post', 'gres') -- 'Postgres'
  - SUBSTRING('Postgres' FROM 1 FOR 4) -- 'Post'
  - TRIM(' hello ') -- 'hello'
- Numeric Functions
  - ABS(-10) -- 10
  - CEIL(7.2) -- 8
  - FLOOR(7.8) -- 7
  - ROUND(7.56,1) -- 7.6
  - POWER(2,3) -- 8
  - SQRT(16) -- 4
- Date/Time Functions
  - CURRENT_DATE -- today's date
  - CURRENT_TIME -- current time
  - CURRENT_TIMESTAMP -- date + time
  - AGE('2025-09-07','2000-01-01') -- interval (25 years etc.)
  - EXTRACT(YEAR FROM CURRENT_DATE) -- 2025
- Conditional Function
  - COALESCE(NULL, 'Default') -- 'Default' (returns first non-null)
  - NULLIF(10,10) -- NULL (returns null if equal, else first value)

## Aggregate Functions

Aggregate functions perform a calculation on a set of values and return a single value.
They often work with GROUP BY.

Common Aggregate Functions in PostgreSQL:

- COUNT()
  - Counts rows.
  - SELECT COUNT(\*) FROM employees; -- all rows
  - SELECT COUNT(salary) FROM employees; -- non-null salaries
- SUM()
  - Adds values.
  - SELECT SUM(salary) AS total_salary FROM employees;
- AVG()
  - Finds the average.
  - SELECT AVG(salary) AS avg_salary FROM employees;
- MIN() / MAX()
  - Finds smallest/largest.
  - SELECT MIN(salary) AS lowest, MAX(salary) AS highest FROM employees;
- STRING_AGG()
  - Concatenates strings with a separator.
  - SELECT STRING_AGG(name, ', ') AS all_names FROM employees;
- ARRAY_AGG()
  - Collects values into an array.
  - SELECT ARRAY_AGG(name) AS name_list FROM employees;
