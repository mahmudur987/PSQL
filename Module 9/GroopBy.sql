

-- groop by

SELECT *FROM students GROUP BY country;
SELECT country FROM students GROUP BY country;

SELECT country,count(*) FROM students GROUP BY country;



SELECT country ,avg(age) FROM students GROUP BY country HAVING avg(age) >20;




SELECT extract(year FROM dob)as birth_year,count(*) as total_born from students GROUP BY birth_year;