-- DDL data definition language

-- CREATE TABLE person2 (
--     id SERIAL PRIMARY KEY,
--     user_name VARCHAR(50),
--     age NUMERIC
 
-- );


-- drop Table person2









-- 1 add column
ALTER TABLE person2 ADD COLUMN email VARCHAR(50) DEFAULT 'default@gmail.com' NOT NULL;
-- 2 delete column
ALTER TABLE person2 DROP COLUMN email;
-- 3 rename column name

ALTER Table person2 RENAME COLUMN age to user_age;
-- 4 change column name data type

ALTER Table person2 ALTER COLUMN user_name TYPE VARCHAR(60);

-- 5 add constrain

ALTER Table person2 ALTER COLUMN user_age set NOT NULL
-- 6 remove constrain

ALTER Table person2 ALTER COLUMN user_age DROP NOT NULL;
-- 7 add  pk /unique constrain
ALTER TABLE person2 ADD constraint unique_person2_user_age UNIQUE(user_age); 
-- 8 drop  pk /unique constrain
ALTER TABLE person2 DROP constraint unique_person2_user_age UNIQUE(user_age); 

-- remove data/ row  from table

TRUNCATE Table user2











INSERT INTO person2 (id,user_name, age, email) 
VALUES 
    (5,'Bob Smith', 30,'hgffg@gmail.com');

    SELECT *from "person2";