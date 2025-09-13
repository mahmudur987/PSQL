# PostgreSQL Tutorial Notes

This note covers fundamental PostgreSQL topics with detailed examples. It is structured to help you understand and write queries effectively.

---

## 1. Handling NULL with COALESCE

**COALESCE(value1, value2, ..., valueN)** returns the first non-NULL value.

### Example
```sql
SELECT COALESCE(NULL, 'fallback') AS result;
-- result = 'fallback'
```

### Use Cases
```sql
-- Replace NULL with default
SELECT COALESCE(middle_name, 'N/A') AS middle_name FROM users;

-- Prevent NULL in calculations
SELECT name, COALESCE(salary, 0) + COALESCE(bonus, 0) AS total_income FROM employees;

-- String concatenation
SELECT first_name || ' ' || COALESCE(middle_name, '') || ' ' || last_name AS full_name FROM users;
```

---

## 2. Updating Data

### Basic Update
```sql
UPDATE employees SET salary = 60000 WHERE id = 3;
```

### Update Multiple Columns
```sql
UPDATE employees SET salary = 65000, bonus = 5000 WHERE id = 3;
```

### Update Using COALESCE
```sql
UPDATE employees
SET name  = COALESCE($1, name),
    email = COALESCE($2, email)
WHERE id = $3;
```

### Check Updates
```sql
UPDATE employees SET salary = salary * 1.05
WHERE department = 'HR'
RETURNING id, name, salary;
```

---

## 3. Deleting Data

### Basic Delete
```sql
DELETE FROM employees WHERE id = 5;
```

### Delete All Rows
```sql
DELETE FROM employees;
TRUNCATE TABLE employees RESTART IDENTITY;
```

### Delete with Subquery
```sql
DELETE FROM employees WHERE department_id IN (
    SELECT id FROM departments WHERE budget < 10000
);
```

### Delete with Returning
```sql
DELETE FROM employees WHERE salary < 30000 RETURNING id, name, salary;
```

---

## 4. Foreign Key

### Example
```sql
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    department_id INT,
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES departments(id)
);
```

### ON DELETE Options
- `NO ACTION` (default) – block delete
- `CASCADE` – delete child rows
- `SET NULL` – set foreign key to NULL
- `SET DEFAULT` – set foreign key to default value

```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE
);
```

---

## 5. Joins

### INNER JOIN
```sql
SELECT e.id, e.name, d.name AS department
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;
```
- Returns only rows with matches in both tables.

### LEFT JOIN
```sql
SELECT e.id, e.name, d.name AS department
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;
```
- Returns all rows from left table; NULL if no match in right.

### RIGHT JOIN
```sql
SELECT e.id, e.name, d.name AS department
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;
```
- Returns all rows from right table; NULL if no match in left.

### FULL JOIN
```sql
SELECT e.id, e.name, d.name AS department
FROM employees e
FULL JOIN departments d ON e.department_id = d.id;
```
- Returns all rows from both tables; NULLs where no match.

---

## 6. Subqueries

### WHERE Subquery
```sql
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

### IN Subquery
```sql
SELECT name
FROM employees
WHERE department_id IN (
    SELECT id FROM departments WHERE name IN ('Sales', 'HR')
);
```

### FROM Subquery (Derived Table)
```sql
SELECT d.name, avg_table.avg_salary
FROM departments d
JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) avg_table ON d.id = avg_table.department_id;
```

### SELECT Subquery
```sql
SELECT name, salary, (SELECT AVG(salary) FROM employees) AS company_avg
FROM employees;
```

---

## 7. Functions

### Built-in Functions
```sql
SELECT COUNT(*) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT UPPER(name) FROM employees;
SELECT ROUND(123.456, 2);
SELECT NOW();
```

### User-defined Function
```sql
CREATE FUNCTION add_numbers(a INT, b INT) RETURNS INT AS $$
BEGIN
    RETURN a + b;
END;
$$ LANGUAGE plpgsql;

SELECT add_numbers(5, 7);
```

### Function Returning Table
```sql
CREATE FUNCTION get_high_salary(min_salary NUMERIC)
RETURNS TABLE(id INT, name TEXT, salary NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, salary FROM employees WHERE salary > min_salary;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_high_salary(50000);
```

---

## 8. Procedures

### Example: Increase Salary
```sql
CREATE PROCEDURE increase_salary(dept_id INT, percent NUMERIC)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE employees SET salary = salary + (salary * percent / 100) WHERE department_id = dept_id;
    RAISE NOTICE 'Salaries increased by % percent in department %', percent, dept_id;
END;
$$;

CALL increase_salary(1, 10);
```

### Insert with Logging
```sql
CREATE PROCEDURE add_employee(emp_name TEXT, dept_id INT, salary NUMERIC)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO employees(name, department_id, salary) VALUES(emp_name, dept_id, salary);
    RAISE NOTICE 'Employee % added successfully', emp_name;
END;
$$;

CALL add_employee('Alice', 2, 55000);
```

---

## 9. Triggers

### Log New Employee Example
```sql
CREATE TABLE employee_log (
    id SERIAL PRIMARY KEY,
    emp_name TEXT,
    action_time TIMESTAMP
);

CREATE FUNCTION log_new_employee() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employee_log(emp_name, action_time) VALUES (NEW.name, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_employee
AFTER INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION log_new_employee();
```

### Prevent Negative Salary
```sql
CREATE FUNCTION prevent_negative_salary() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.salary < 0 THEN
        RAISE EXCEPTION 'Salary cannot be negative!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_salary
BEFORE INSERT OR UPDATE ON employees
FOR EACH ROW
EXECUTE FUNCTION prevent_negative_salary();
```

---

This note provides **ready-to-use examples** and explanations for writing PostgreSQL queries, handling NULLs, managing joins, subqueries, functions, procedures, and triggers.

