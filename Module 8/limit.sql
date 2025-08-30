-- limit



SELECT *FROM students LIMIT 5;


-- offset

-- page number=0
-- page limit=5

SELECT *FROM students LIMIT 5 OFFSET 5*0;


-- delete

DELETE FROM students WHERE first_name=iana;
