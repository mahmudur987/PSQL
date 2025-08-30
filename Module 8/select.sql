CREATE Table students(
student_id SERIAL  PRIMARY key,
first_name VARCHAR(50),
last_name VARCHAR(50),
age INT,
grade CHAR(2),
course VARCHAR(50),
dob DATE,
blood_group VARCHAR(5),
country VARCHAR(50));

INSERT INTO students (first_name, last_name, age, grade, course, dob, blood_group, country) VALUES
('Alice', 'Smith', 22, 'A', 'Computer Science', '2003-04-12', 'O+', 'USA'),
('Bob', 'Johnson', 21, 'B', 'Mechanical Engineering', '2004-06-18', 'A+', 'Canada'),
('Charlie', 'Brown', 23, 'A-', 'Business Administration', '2002-09-25', 'B-', 'UK'),
('Diana', 'Prince', 20, 'B+', 'Information Technology', '2005-01-11', 'AB+', 'Australia'),
('Edward', 'Stone', 19, 'C', 'Civil Engineering', '2006-03-22', 'O-', 'India'),
('Fiona', 'White', 24, 'A+', 'Biochemistry', '2001-12-30', 'B+', 'Germany'),
('George', 'Martin', 22, 'B-', 'Electrical Engineering', '2003-05-17', 'A-', 'Brazil'),
('Hannah', 'Kim', 20, 'A', 'Psychology', '2005-07-08', 'AB-', 'South Korea'),
('Ian', 'Clark', 23, 'B+', 'Physics', '2002-11-15', 'O+', 'France'),
('Jane', 'Doe', 21, 'A-', 'Data Science', '2004-08-19', 'A+', 'USA'),
('Kyle', 'Morris', 19, 'C+', 'Marketing', '2006-10-10', 'B-', 'Mexico'),
('Laura', 'Perry', 20, 'B', 'Graphic Design', '2005-02-05', 'AB+', 'Italy'),
('Michael', 'Adams', 25, 'A+', 'Law', '2000-04-25', 'O-', 'South Africa'),
('Nina', 'Walker', 18, 'B-', 'Nursing', '2007-09-20', 'A-', 'Netherlands'),
('Oliver', 'Scott', 22, 'B+', 'Finance', '2003-12-13', 'B+', 'Sweden');

-- sort
SELECT * FROM students ORDER BY age ASC;
SELECT * FROM students ORDER BY first_name DESC


-- unique values from column

SELECT DISTINCT country FROM students;
SELECT DISTINCT blood_group FROM students;


-- filtering

SELECT *FROM students WHERE country='USA';
SELECT *FROM students WHERE grade='A' AND course ='Computer Science';