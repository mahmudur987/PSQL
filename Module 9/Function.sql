-- date

SHOW timezone;



SELECT  now();

SELECT CURRENT_DATE;

SELECT now()::date;
SELECT now()::time;
SELECT to_char(now(),'yyyy/mm/dd');
-- age


SELECT age(CURRENT_DATE,'1995-05-05');

-- extract for collect date,month,year


SELECT EXTRACT(MONTH FROM '1995-05-05'::date) AS month;
;
CREATE Table timeZ(ts TIMESTAMP without time zone ,tsz TIMESTAMP with time zone);



INSERT INTO timez VALUES('2024-1-12 10:45:00','2024-1-12 10:46:00');


SELECT *FROM students