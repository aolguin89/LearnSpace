# Database Scripts

## Setup Instructions

### 1. Create database and tables

```bash
mysql -u root -p < src/main/resources/db/schema.sql
```

### 2. Load test data

```bash
mysql -u root -p learnspace_db < src/main/resources/db/data.sql
```

### 3. Verify

```bash
mysql -u root -p learnspace_db
SHOW TABLES;
SELECT username, role FROM users;
```

## Test Credentials

| Username  | Password | Role      |
|-----------|----------|-----------|
| admin     | admin123 | admin     |
| jperez    | prof123  | professor |
| mgarcia   | prof123  | professor |
| clopez    | est123   | student   |
| lmartinez | est123   | student   |
| psanchez  | est123   | student   |

## Tables

| Table           | Description                                 |
|-----------------|---------------------------------------------|
| `users`         | System users (admins, professors, students) |
| `courses`       | Courses with professor assignment           |
| `enrollments`   | Student-course relationships                |
| `exams`         | Exams associated to courses                 |
| `exam_attempts` | Student exam attempt records                |

## Notes

- Scripts are idempotent: safe to re-run during development
- Passwords hashed with SHA2 256-bit
- ⚠️ TODO: Upgrade to bcrypt for production
- Compatible with MySQL 8.x
- Encoding: utf8mb4 (full Unicode support)