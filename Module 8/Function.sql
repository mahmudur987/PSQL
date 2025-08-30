SELECT * FROM students 


-- scalar function

SELECT upper(first_name) FROM students;
SELECT concat(first_name,' ',last_name) FROM students;




-- aggregate

SELECT avg(age) FROM students;
SELECT max(age) FROM students;
SELECT max(length(first_name)) FROM students;


-- not

SELECT *FROM students WHERE NOT country='USA'; 


-- null coalesce for remove null

SELECT COALESCE(first_name,'gffgfgf'),*from students;


-- in


SELECT *FROM students WHERE country IN('USA',"uk",'canada');
SELECT *FROM students WHERE country NOT IN('USA',"uk",'canada')

-- between


SELECT *FROM students WHERE age  BETWEEN 19 AND 22;



-- like


SELECT *FROM students WHERE first_name like '%a'
