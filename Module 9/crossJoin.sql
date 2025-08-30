CREATE TABLE department (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);
CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INTEGER,
    department_id INTEGER REFERENCES department(id)
);
INSERT INTO department (name) VALUES
    ('Human Resources'),
    ('Engineering');
INSERT INTO employee (name, age, department_id) VALUES
    ('Alice', 30, 1),
    ('Bob', 28, 2);
SELECT*FROM employee;
SELECT*FROM department;
SELECT*FROM department CROSS JOIN employee;
SELECT*FROM department CROSS JOIN employee;
SELECT*FROM employee NATURAL JOIN department;
SELECT*FROM employee  JOIN department  USING(department_id);