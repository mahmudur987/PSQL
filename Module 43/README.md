# Database Notes

## 1. Database vs Data vs Information
- **Database**: Organized collection of data stored electronically.
- **Data**: Raw facts (e.g., `42`, `'John Doe'`, `'2025-08-31'`).
- **Information**: Processed data that has meaning (e.g., `'John borrowed 42 books in August 2025'`).
- **Analogy**: Data = Lego pieces, Database = box, Information = built Lego model.

## 2. Why File Systems Fail
1. Data redundancy & inconsistency.
2. Difficulty in data retrieval.
3. Poor data security.
4. No concurrency control.
5. Data integrity issues.
6. Scalability problems.

## 3. Types of Database Models
1. **Hierarchical Model**: Tree structure, one parent per child.
2. **Network Model**: Graph structure, multiple parents per child.
3. **Relational Model**: Tables with rows & columns, uses SQL.
4. **Entity-Relationship Model**: Conceptual, ER diagrams.
5. **Object-Oriented Model**: Data as objects with methods.
6. **Document Model (NoSQL)**: JSON/BSON documents.
7. **Key-Value Model (NoSQL)**: Dictionary-like storage.
8. **Column-Oriented Model**: Columns stored separately for analytics.
- PostgreSQL: Object-relational, supports JSON & some object-oriented features.

## 4. Anatomy of a Table / Relation
- **Table Name**: Unique identifier.
- **Columns (Attributes)**: Name + data type.
- **Rows (Tuples)**: Records.
- **Primary Key (PK)**: Unique identifier.
- **Foreign Key (FK)**: Links to another table.
- **Constraints**: NOT NULL, UNIQUE, CHECK, DEFAULT.
- **Schema**: Namespace organizing tables.

**Example Table: Students**
| id (PK) | name | age | email |
|---------|------|-----|-------|
| 1       | Alice| 20  | alice@example.com |
| 2       | Bob  | 22  | bob@example.com   |

PostgreSQL Example:
```sql
CREATE TABLE Students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age > 0),
    email VARCHAR(150) UNIQUE
);
```

## 5. Keys in Databases

### Super Key
- Any set of columns that **uniquely identifies a row**.
- Can contain extra attributes.
- Example: `{id}`, `{email}`, `{id, name}`

### Candidate Key
- Minimal super key (no redundant columns).
- Every table can have multiple candidate keys.

### Primary Key
- Chosen candidate key, main identifier.
- Cannot be NULL.

### Alternate Key
- Candidate keys not chosen as primary key.

### Simple Key
- Single-column key.

### Composite Key
- Multiple columns combined to uniquely identify a row.
- Example: `(student_id, course_id)` in an enrollments table.

### Subsets & Proper Subsets
- **Subset**: Any set of elements within a set.
- **Proper Subset**: Subset that is **smaller than the original set**.
- Used to check minimality when finding candidate keys.

### Foreign Key (FK)
- Column in one table referencing **Primary Key** in another.
- Maintains **referential integrity**.
- Supports cascading actions: `ON DELETE CASCADE`, `ON UPDATE CASCADE`, `ON DELETE SET NULL`.

PostgreSQL Example:
```sql
CREATE TABLE Enrollments (
    enroll_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES Students(student_id) ON DELETE CASCADE,
    course_id VARCHAR(20) NOT NULL
);
```

## 6. Database Design Process (Step-by-Step)
1. Gather requirements (functional & non-functional).
2. Identify entities & attributes.
3. Define relationships (1:1, 1:N, M:N).
4. Choose keys (PK, Alternate, Composite, FKs).
5. Normalize to remove redundancy (1NF → 3NF).
6. Map to relational schema (tables + columns + constraints).
7. Choose data types & constraints.
8. Indexing strategy.
9. Physical design & performance.
10. Implement DDL (PostgreSQL).
11. Seed, import & manage migrations.
12. Test data & integrity.
13. Security & access control (roles, RLS).
14. Backup, monitoring & maintenance.
15. Change management.

## 7. SDLC (Software Development Life Cycle)
- Structured process for software development.
- Phases:
  1. Requirement Analysis (capture functional & non-functional requirements)
  2. System Design (DB design, architecture)
  3. Implementation / Coding (write code + DB schema)
  4. Testing (unit, integration, system, performance)
  5. Deployment (move to production, apply migrations)
  6. Maintenance (bug fixes, updates, performance tuning)

- SDLC Models: Waterfall, Iterative, Agile, V-Model, Spiral.
- Database design is critical during **System Design & Implementation** phases.

