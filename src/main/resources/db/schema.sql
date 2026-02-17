-- =============================================
-- LearnSpace Database Schema
-- Version: 1.0
-- Description: Initial database structure for
--              learning management system
-- Compatible: MySQL 8.x
-- Encoding: utf8mb4
-- =============================================

-- Create database
CREATE
DATABASE IF NOT EXISTS learnspace_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE learnspace_db;

-- =============================================
-- DROP TABLES (reverse order to respect FKs)
-- =============================================
DROP TABLE IF EXISTS exam_attempts;
DROP TABLE IF EXISTS exams;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS users;

-- =============================================
-- TABLE: users
-- =============================================
CREATE TABLE users
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    username   VARCHAR(50) UNIQUE  NOT NULL,
    email      VARCHAR(100) UNIQUE NOT NULL,
    password   VARCHAR(255)        NOT NULL,
    first_name VARCHAR(50)         NOT NULL,
    last_name  VARCHAR(50)         NOT NULL,
    dni        VARCHAR(15) UNIQUE,
    address    VARCHAR(200),
    phone      VARCHAR(20),
    birth_date DATE,
    gender     ENUM('M', 'F', 'other'),
    role       ENUM('admin', 'professor', 'student') NOT NULL DEFAULT 'student',
    created_at TIMESTAMP                    DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    updated_at TIMESTAMP                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active  BOOLEAN             NOT NULL DEFAULT TRUE,

    -- Indexes for frequently queried columns
    INDEX      idx_username (username),
    INDEX      idx_email (email),
    INDEX      idx_role (role),
    INDEX      idx_is_active (is_active)
);

-- =============================================
-- TABLE: courses
-- =============================================
CREATE TABLE courses
(
    id           INT AUTO_INCREMENT PRIMARY KEY,
    code         VARCHAR(20) UNIQUE,
    name         VARCHAR(200) NOT NULL,
    description  TEXT,
    capacity     INT,
    start_date   DATE,
    end_date     DATE,
    professor_id INT          NOT NULL,
    created_at   TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP             DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active    BOOLEAN      NOT NULL DEFAULT TRUE,

    -- Foreign Keys
    CONSTRAINT fk_courses_professor
        FOREIGN KEY (professor_id)
            REFERENCES users (id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,

    -- Indexes
    INDEX        idx_professor (professor_id),
    INDEX        idx_is_active (is_active)
);

-- =============================================
-- TABLE: enrollments
-- =============================================
CREATE TABLE enrollments
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT NOT NULL,
    course_id       INT NOT NULL,
    enrolled_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status          ENUM('active', 'completed', 'dropped') NOT NULL DEFAULT 'active',
    final_grade     DECIMAL(5, 2),
    completion_date DATE,

    -- Prevent duplicate enrollments
    UNIQUE KEY unique_enrollment (user_id, course_id),

    -- Foreign Keys
    CONSTRAINT fk_enrollments_user
        FOREIGN KEY (user_id)
            REFERENCES users (id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,

    CONSTRAINT fk_enrollments_course
        FOREIGN KEY (course_id)
            REFERENCES courses (id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,

    -- Indexes
    INDEX           idx_user (user_id),
    INDEX           idx_course (course_id),
    INDEX           idx_status (status)
);

-- =============================================
-- TABLE: exams
-- =============================================
CREATE TABLE exams
(
    id               INT AUTO_INCREMENT PRIMARY KEY,
    course_id        INT           NOT NULL,
    title            VARCHAR(200)  NOT NULL,
    description      TEXT,
    max_attempts     INT           NOT NULL DEFAULT 1,
    passing_score    DECIMAL(5, 2) NOT NULL DEFAULT 60.00,
    duration_minutes INT           NOT NULL DEFAULT 60,
    available_from   DATETIME,
    available_until  DATETIME,
    created_at       TIMESTAMP              DEFAULT CURRENT_TIMESTAMP,
    is_active        BOOLEAN       NOT NULL DEFAULT TRUE,

    -- Foreign Keys
    CONSTRAINT fk_exams_course
        FOREIGN KEY (course_id)
            REFERENCES courses (id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,

    -- Indexes
    INDEX            idx_course (course_id),
    INDEX            idx_available (available_from, available_until),
    INDEX            idx_is_active (is_active)
);

-- =============================================
-- TABLE: exam_attempts
-- =============================================
CREATE TABLE exam_attempts
(
    id                 INT AUTO_INCREMENT PRIMARY KEY,
    exam_id            INT NOT NULL,
    user_id            INT NOT NULL,
    attempt_number     INT NOT NULL,
    score              DECIMAL(5, 2),
    started_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    submitted_at       TIMESTAMP NULL,
    time_spent_minutes INT,
    status             ENUM('in_progress', 'submitted', 'graded') NOT NULL DEFAULT 'in_progress',
    feedback           TEXT,

    -- Foreign Keys
    CONSTRAINT fk_attempts_exam
        FOREIGN KEY (exam_id)
            REFERENCES exams (id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,

    CONSTRAINT fk_attempts_user
        FOREIGN KEY (user_id)
            REFERENCES users (id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,

    -- Indexes
    INDEX              idx_exam (exam_id),
    INDEX              idx_user (user_id),
    INDEX              idx_status (status)
);