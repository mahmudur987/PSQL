
# DBMS & PostgreSQL Notes

This repository contains notes and examples of key DBMS concepts and PostgreSQL basics, including normalization, functional dependencies, data anomalies, and many-to-many relationships.

---

## 1. Data Anomalies

Data anomalies occur when a database is not properly normalized and has redundant or inconsistent data.  

### Types of Data Anomalies

1. **Insertion Anomaly**  
   - Cannot insert data without unnecessary or incomplete information.  
   **Example:** Cannot add a new course unless a student registers.

2. **Update Anomaly**  
   - Updating one piece of data requires multiple updates.  
   **Example:** Changing "Dr. Lee" to "Dr. Leo" in multiple rows.

3. **Deletion Anomaly**  
   - Deleting one record accidentally removes other useful data.  
   **Example:** Deleting Alice’s enrollment also removes info about the SQL course.

---

## 2. Normalization

Normalization organizes data to reduce redundancy and improve integrity.  

### Functional Dependency

If attribute `A` uniquely determines attribute `B`:  
```
A → B
```
**Example:**  
- `StudentID → StudentName`  
- `Course → Instructor`

### Normal Forms

#### 2.1 First Normal Form (1NF)
- No repeating groups or multi-valued attributes.  
- Every cell contains atomic (indivisible) values.

**Example (Before 1NF):**
| StudentID | StudentName | Courses        |
|-----------|-------------|----------------|
| 1         | Alice       | DBMS, SQL      |

**After 1NF:**
| StudentID | StudentName | Course   |
|-----------|-------------|----------|
| 1         | Alice       | DBMS     |
| 1         | Alice       | SQL      |

#### 2.2 Second Normal Form (2NF)
- Table is in 1NF.  
- No partial dependency (non-key attributes depend on the **whole** primary key).

**Example (Before 2NF):**
| StudentID | CourseID | StudentName | CourseName | Instructor |
|-----------|----------|-------------|------------|------------|

**After 2NF (Split tables):**

**Students Table**
| StudentID | StudentName |
|-----------|-------------|

**Courses Table**
| CourseID | CourseName | Instructor |

**Enrollment Table**
| StudentID | CourseID |

#### 2.3 Third Normal Form (3NF)
- Table is in 2NF.  
- No transitive dependency (non-key attributes do not depend on other non-key attributes).

**Example (Before 3NF):**
| StudentID | StudentName | DeptID | DeptName | DeptHead |

**After 3NF (Split tables):**

**Students Table**
| StudentID | StudentName | DeptID |

**Departments Table**
| DeptID | DeptName | DeptHead |

#### 2.4 Boyce–Codd Normal Form (BCNF)
- Every determinant is a candidate key.  
- Stronger version of 3NF to eliminate remaining anomalies.

---

## 3. Decomposition

### Lossless Decomposition
- Original relation can be **reconstructed** by joining decomposed tables.  
**Example:** Students, Courses, and Enrollment tables.

### Lossy Decomposition
- Original relation **cannot be perfectly reconstructed**; spurious tuples may appear.  
**Example:** Joining Employees and Departments on `EmpName` can produce incorrect rows.

---

## 4. Resolving Many-to-Many Relationship

- Direct M:N relationship is not allowed.  
- Use a **junction (bridge) table**.

**Example:** Students and Courses

**Students Table**
| StudentID | StudentName |

**Courses Table**
| CourseID | CourseName |

**Enrollment Table**
| StudentID | CourseID |

**PostgreSQL Implementation:**
```sql
CREATE TABLE Students (
    StudentID SERIAL PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL
);

CREATE TABLE Courses (
    CourseID SERIAL PRIMARY KEY,
    CourseName VARCHAR(50) NOT NULL
);

CREATE TABLE Enrollment (
    StudentID INT REFERENCES Students(StudentID),
    CourseID INT REFERENCES Courses(CourseID),
    PRIMARY KEY (StudentID, CourseID)
);
```

---

## 5. PostgreSQL Overview

**PostgreSQL** is a powerful, open-source **object-relational database system (ORDBMS)**.

### Key Features
- Open-source & free  
- ACID compliant  
- Supports SQL standards  
- Advanced data types (JSON, ARRAY, UUID, HSTORE)  
- Extensible and customizable  
- Multi-Version Concurrency Control (MVCC)  
- Strong data integrity with constraints and triggers  

### Example
```sql
CREATE TABLE Students (
    StudentID SERIAL PRIMARY KEY,
    StudentName VARCHAR(50),
    Age INT
);

INSERT INTO Students (StudentName, Age)
VALUES ('Alice', 21), ('Bob', 22);

SELECT * FROM Students;
```

---

## 6. References
- PostgreSQL Official Documentation: https://www.postgresql.org/docs/
- Database System Concepts by Silberschatz, Korth, and Sudarshan  
