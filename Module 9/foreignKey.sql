-- Active: 1747488451886@@127.0.0.1@5432@ph
-- 

CREATE TABLE "user"(
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL
);
select * from user;

create Table post(
    id SERIAL PRIMARY key,
    title VARCHAR(50),
    description TEXT,
    user_id INTEGER REFERENCES "user"(id)  on Delete set DEFAULT DEFAULT 2
);
DROP Table post;


INSERT INTO "user" (user_name) VALUES 
    ('Alice Johnson'),
    ('Bob Smith'),
    ('Charlie Brown');

SELECT  *FROM "user";

DROP TABLE "user";
INSERT INTO post (title, description, user_id) VALUES
    ('Learning SQL', 'Understanding the basics of SQL and database management.', 1),
    ('Node.js Tutorial', 'A complete guide to building backend applications with Node.js.', 2),
    ('Frontend Development', 'Introduction to HTML, CSS, and JavaScript.', 3),
    ('GraphQL Basics', 'Learn how to use GraphQL for building APIs.', 1),
    ('React Best Practices', 'How to structure and optimize React applications.', 2),
    ('Database Relationships', 'Exploring One-to-Many and Many-to-Many relationships in databases.', 3);




-- foreign key on Delete restriction is default behavior;you cant delete a row which nis use ase a foreign key

DELETE FROM "user" WHERE id=2;


-- on Delete Cascade.when delete user its also delete post of that user
-- you need to add on delete cascade on fk 
DELETE FROM "user" WHERE id=2;



-- when you create table set null on delete.
DELETE FROM "user" WHERE id=2;






-- join table 
SELECT title,user_name FROM post JOIN "user" on post.user_id="user".id;
SELECT * FROM post JOIN "user" on post.user_id="user".id;
SELECT post.id FROM post JOIN "user" on post.user_id="user".id;
SELECT "user".id FROM post JOIN "user" on post.user_id="user".id;


SELECT title,user_name FROM post as p JOIN "user" as u on p.user_id=u.id;
INSERT INTO post (id,title, description, user_id) VALUES
    (7,'Learning SQL', 'Understanding the basics of SQL and database management.', NULL);
SELECT *FROM post;

DELETE FROM post WHERE id=7;

-- left join

SELECT * FROM post LEFT JOIN "user" on post.user_id="user".id;
SELECT * FROM post right JOIN "user" on post.user_id="user".id;
SELECT * FROM post FULL OUTER JOIN "user" on post.user_id="user".id;



