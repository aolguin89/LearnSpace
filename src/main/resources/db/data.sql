-- =============================================
-- LearnSpace Test Data
-- Version: 1.0
-- Description: Initial test data for development
-- ⚠️  Run schema.sql before this script
-- =============================================

USE learnspace_db;

-- =============================================
-- USERS
-- =============================================
INSERT INTO users (username, email, password, first_name, last_name, dni, address, phone, birth_date, gender, role)
VALUES ('admin',
        'admin@learnspace.com',
        SHA2('admin123', 256),
        'Admin',
        'Sistema',
        '00000000',
        'Av. España 464, Río Cuarto, Córdoba',
        '(0358) 4676500',
        '1985-01-01',
        'M',
        'admin'),
       ('jperez',
        'jperez@unrc.edu.ar',
        SHA2('prof123', 256),
        'Juan',
        'Pérez',
        '20111222',
        'Sadi Carnot 1405, Río Cuarto, Córdoba',
        '(0358) 4623100',
        '1978-03-22',
        'M',
        'professor'),
       ('mgarcia',
        'mgarcia@unrc.edu.ar',
        SHA2('prof123', 256),
        'María',
        'García',
        '25333444',
        'Bv. Roca 870, Río Cuarto, Córdoba',
        '(0358) 4631200',
        '1982-07-14',
        'F',
        'professor'),
       ('clopez',
        'clopez@estudiantes.unrc.edu.ar',
        SHA2('est123', 256),
        'Carlos',
        'López',
        '38555666',
        'Belgrano 750, Las Higueras, Córdoba',
        '(0358) 4645300',
        '2001-11-05',
        'M',
        'student'),
       ('lmartinez',
        'lmartinez@estudiantes.unrc.edu.ar',
        SHA2('est123', 256),
        'Laura',
        'Martínez',
        '40777888',
        'Cap. Castagnari 320, Las Higueras, Córdoba',
        '(0358) 4658400',
        '2003-04-18',
        'F',
        'student'),
       ('psanchez',
        'psanchez@estudiantes.unrc.edu.ar',
        SHA2('est123', 256),
        'Pedro',
        'Sánchez',
        '42999000',
        'Lavalle 540, Río Cuarto, Córdoba',
        '(0358) 4661500',
        '2002-09-30',
        'M',
        'student');

-- =============================================
-- COURSES
-- =============================================
INSERT INTO courses (code, name, description, capacity, start_date, end_date, professor_id)
VALUES ('CS101',
        'Introducción a Java',
        'Curso básico de programación orientada a objetos con Java. Cubre fundamentos del lenguaje, estructuras de control, clases y objetos.',
        30,
        '2026-03-01',
        '2026-07-31',
        2),
       ('DB201',
        'Bases de Datos Relacionales',
        'Fundamentos de bases de datos relacionales. SQL, diseño de esquemas, normalización y optimización de consultas.',
        25,
        '2026-03-01',
        '2026-07-31',
        2),
       ('WEB301',
        'Desarrollo Web con JSP y Servlets',
        'Desarrollo de aplicaciones web con Java EE. JSP, Servlets, patrón MVC y conexión a bases de datos.',
        20,
        '2026-03-01',
        '2026-07-31',
        3);

-- =============================================
-- ENROLLMENTS
-- =============================================
INSERT INTO enrollments (user_id, course_id, status)
VALUES (4, 1, 'active'),
       (4, 2, 'active'),
       (5, 1, 'active'),
       (5, 3, 'active'),
       (6, 2, 'active'),
       (6, 3, 'active');

-- =============================================
-- EXAMS
-- =============================================
INSERT INTO exams (course_id, title, description, max_attempts, passing_score, duration_minutes, available_from,
                   available_until)
VALUES (1,
        'Parcial 1 - Fundamentos de Java',
        'Evaluación de conceptos básicos: variables, tipos de datos, estructuras de control y métodos.',
        2,
        60.00,
        90,
        '2026-04-01 08:00:00',
        '2026-04-07 23:59:00'),
       (1,
        'Parcial 2 - POO en Java',
        'Evaluación de programación orientada a objetos: clases, herencia, polimorfismo e interfaces.',
        2,
        60.00,
        90,
        '2026-05-15 08:00:00',
        '2026-05-21 23:59:00'),
       (2,
        'Parcial 1 - SQL Básico',
        'Evaluación de consultas SQL: SELECT, INSERT, UPDATE, DELETE y JOINs básicos.',
        1,
        70.00,
        60,
        '2026-04-01 08:00:00',
        '2026-04-07 23:59:00'),
       (3,
        'Parcial 1 - JSP y Servlets',
        'Evaluación de desarrollo web: ciclo de vida de Servlets, JSP y patrón MVC.',
        2,
        65.00,
        120,
        '2026-04-15 08:00:00',
        '2026-04-21 23:59:00');

-- =============================================
-- EXAM ATTEMPTS
-- =============================================
INSERT INTO exam_attempts (exam_id, user_id, attempt_number, score, submitted_at, time_spent_minutes, status, feedback)
VALUES (1,
        4,
        1,
        75.00,
        '2026-04-03 10:30:00',
        80,
        'graded',
        'Buen manejo de los conceptos básicos. Revisar estructuras de control.'),
       (1,
        5,
        1,
        55.00,
        '2026-04-04 14:00:00',
        88,
        'graded',
        'Necesita reforzar el concepto de métodos y su alcance.'),
       (1,
        5,
        2,
        72.00,
        '2026-04-06 16:00:00',
        75,
        'graded',
        'Mejoró notablemente. Aprobado.'),
       (3,
        6,
        1,
        88.00,
        '2026-04-02 11:00:00',
        55,
        'graded',
        'Excelente dominio de SQL. Muy buenos resultados en JOINs.');