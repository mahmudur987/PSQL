-- Active: 1747974892076@@Localhost@5432@modele10




CREATE view dept_avg_salary as
SELECT department_name,sum(salary) FROM employees GROUP BY department_name;


SELECT * from dept_avg_salary;




