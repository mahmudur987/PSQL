# SQL Beginner's Guide with PostgreSQL Examples

## Table of Contents

1. [Introduction to SQL](#introduction-to-sql)
2. [pgAdmin Basics](#pgadmin-basics)
3. [Beekeeper Studio Installation](#beekeeper-studio-installation)
4. [SQL Data Types](#sql-data-types)
   - Integer Types
   - Boolean Type
   - Other Types
5. [Creating and Dropping Databases & Tables](#creating-and-dropping-databases--tables)
6. [Column Constraints](#column-constraints)
7. [Multiple Constraints & Functions](#multiple-constraints--functions)
8. [Primary Key & Unique Constraints](#primary-key--unique-constraints)
9. [Inserting Data](#inserting-data)
   - With Column Names
   - Without Column Names
   - Multiple Rows
   - Using SELECT
   - Using RETURNING

---

## Introduction to SQL

- SQL (Structured Query Language) is used to interact with relational databases like PostgreSQL, MySQL, SQLite, SQL Server.
- Main categories of SQL commands:
  - **DDL:** `CREATE`, `DROP`
  - **DML:** `INSERT`, `UPDATE`, `DELETE`
  - **DQL:** `SELECT`
  - **DCL:** `GRANT`, `REVOKE`

### Example:

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150)
);
SELECT * FROM users;
pgAdmin Basics
GUI tool for managing PostgreSQL databases.

Key Steps:

Connect to server

Create database:


CREATE DATABASE mydb;
Create table:


CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150)
);
Insert & query data

Export/import CSV

Beekeeper Studio Installation
Download from https://www.beekeeperstudio.io/download

Install .exe on Windows

Launch → Create connection → Enter host, port, user, password, database

Features: Query editor, table browser, multi-database support, export data

SQL Data Types
Integer Types
Type	Storage	Range	Example
SMALLINT	2 bytes	-32,768 to 32,767	age
INTEGER (INT)	4 bytes	-2B to 2B	id
BIGINT	8 bytes	Very large	financial totals
SERIAL	4 bytes	auto-increment	primary keys
BIGSERIAL	8 bytes	auto-increment	large IDs

Boolean Type
Stores TRUE or FALSE


is_active BOOLEAN DEFAULT TRUE;
Other Types
Text/Character: VARCHAR(n), TEXT, CHAR(n)

Date/Time: DATE, TIME, TIMESTAMP, TIMESTAMPTZ, INTERVAL

UUID: UUID DEFAULT gen_random_uuid()

JSON/JSONB: for structured data

Array: tags TEXT[]

Binary: BYTEA

Enum: user-defined set

IP: CIDR, INET

Creating and Dropping Databases & Tables
Create Database

CREATE DATABASE library;
\c library
Drop Database

DROP DATABASE library;
DROP DATABASE library WITH (FORCE);
Create Table

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100),
    published_year INT,
    available BOOLEAN DEFAULT TRUE
);
Drop Table

DROP TABLE books;
DROP TABLE IF EXISTS books;
DROP TABLE books CASCADE; -- removes dependent objects
Column Constraints
Constraint	Description	Example
NOT NULL	Cannot be empty	name VARCHAR(100) NOT NULL
UNIQUE	All values must be unique	email VARCHAR(150) UNIQUE
PRIMARY KEY	Unique + Not Null	id SERIAL PRIMARY KEY
DEFAULT	Default value if not provided	is_active BOOLEAN DEFAULT TRUE
CHECK	Restrict values	age SMALLINT CHECK (age >= 0)
FOREIGN KEY	Link to another table	user_id INT REFERENCES users(id)

Example:

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    age SMALLINT CHECK (age >= 0),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
Multiple Constraints & Functions
Using Functions in Constraints
DEFAULT with function: created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

CHECK with function:


CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL CHECK (initcap(name) = name),
    salary NUMERIC CHECK (salary > 0),
    join_date DATE DEFAULT CURRENT_DATE
);
Custom Function Example

CREATE FUNCTION is_adult(age SMALLINT) RETURNS BOOLEAN AS $$
BEGIN
    RETURN age >= 18;
END;
$$ LANGUAGE plpgsql;

CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age SMALLINT CHECK (is_adult(age))
);
Primary Key & Unique Constraints

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    age SMALLINT CHECK (age >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
id → PRIMARY KEY → unique + not null

email → UNIQUE → no duplicates

Inserting Data
With Column Names

INSERT INTO users (name, email, age)
VALUES ('Alice', 'alice@mail.com', 25);
Without Column Names

INSERT INTO users
VALUES (DEFAULT, 'Bob', 'bob@mail.com', 30, DEFAULT, DEFAULT);
Multiple Rows

INSERT INTO users (name, email, age)
VALUES
('Charlie', 'charlie@mail.com', 28),
('Diana', 'diana@mail.com', 22);
Using SELECT

INSERT INTO users (name, email, age)
SELECT name, email, age FROM temp_users WHERE age >= 18;
Using RETURNING

INSERT INTO users (name, email, age)
VALUES ('Eve', 'eve@mail.com', 35)
RETURNING id, created_at;
✅ General Insert Patterns


-- Single Row
INSERT INTO table_name (col1, col2) VALUES (v1, v2);

-- Multiple Rows
INSERT INTO table_name (col1, col2) VALUES (v1,v2), (v3,v4);

-- Using SELECT
INSERT INTO table_name (col1, col2) SELECT colA, colB FROM other_table;

-- Returning values
INSERT INTO table_name (...) VALUES (...) RETURNING column_name;
```
