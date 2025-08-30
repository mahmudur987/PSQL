


SELECT * FROM employees;


CREATE Function avg_count()
RETURNS INT
LANGUAGE SQL
AS
$$

SELECT count(*) FROM employees;




$$;


SELECT avg_count();
CREATE Function  delete_employee()
RETURNS void
LANGUAGE SQL
AS
$$

DELETE FROM employees WHERE employee_id = 30;



$$;


SELECT delete_employee();




CREATE or REPLACE Function delete_employee_by_id(emp_id INT)
RETURNS void
LANGUAGE SQL
AS
$$
DELETE FROM employees WHERE employee_id = emp_id;
$$;
SELECT FROM delete_employee_by_id(115);










CREATE or REPLACE FUNCTION get_employee_by_id(emp_id INT)
RETURNS TABLE(employee_id INT, employee_name VARCHAR, department_name VARCHAR, salary DECIMAL, hire_date DATE)
LANGUAGE SQL    
AS
$$
SELECT * FROM employees WHERE employee_id = emp_id;  


$$;


SELECT * FROM get_employee_by_id(246);







CREATE Procedure remove_emp()
LANGUAGE PLPGSQL
AS
$$
BEGIN
DELETE FROM employees WHERE employee_id = 152;
END
$$


CALL remove_emp();

CREATE Procedure remove_emp_by_id(emp_id INT)
LANGUAGE PLPGSQL
AS
$$
DECLARE
test_var INT;


BEGIN

select employee_id INTO test_var from employees where employee_id = emp_id;

DELETE FROM employees WHERE employee_id = emp_id;
RAISE NOTICE 'Employee with ID % has been removed', test_var;

END
$$ 

CALL remove_emp_by_id(151);



SELECT * FROM employees;