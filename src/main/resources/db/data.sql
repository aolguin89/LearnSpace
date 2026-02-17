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
INSERT INTO users (username, email, password, first_name, last_name, dni, phone, gender, role)
VALUES ('admin',
        'admin@learnspace.com',
        SHA2('admin123', 256),
        'Admin',
        'Sistema',
        '00000000',
        '(0358) 100000',
        'M',
        'admin'),
       ('jperez',
        'jperez@unrc.edu.ar',
        SHA2('prof123', 256),
        'Juan',
        'Pérez',
        '20111222',
        '(0358) 111222',
        'M',
        'professor'),
       ('mgarcia',
        'mgarcia@unrc.edu.ar',
        SHA2('prof123', 256),
        'María',
        'García',
        '25333444',
        '(0358) 333444',
        'F',
        'professor'),
       ('clopez',
        'clopez@estudiantes.unrc.edu.ar',
        SHA2('est123', 256),
        'Carlos',
        'López',
        '38555666',
        '(0358) 555666',
        'M',
        'student'),
       ('lmartinez',
        'lmartinez@estudiantes.unrc.edu.ar',
        SHA2('est123', 256),
        'Laura',
        'Martínez',
        '40777888',
        '(0358) 777888',
        'F',
        'student'),
       ('psanchez',
        'psanchez@estudiantes.unrc.edu.ar',
        SHA2('est123', 256),
        'Pedro',
        'Sánchez',
        '42999000',
        '(0358) 999000',
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
        2 -- jperez
       ),
       ('DB201',
        'Bases de Datos Relacionales',
        'Fundamentos de bases de datos relacionales. SQL, diseño de esquemas, normalización y optimización de consultas.',
        25,
        '2026-03-01',
        '2026-07-31',
        2 -- jperez
       ),
       ('WEB301',
        'Desarrollo Web con JSP y Servlets',
        'Desarrollo de aplicaciones web con Java EE. JSP, Servlets, patrón MVC y conexión a bases de datos.',
        20,
        '2026-03-01',
        '2026-07-31',
        3 -- mgarcia
       );

-- =============================================
-- ENROLLMENTS
-- =============================================
INSERT INTO enrollments (user_id, course_id, status)
VALUES (4, 1, 'active'), -- clopez en CS101
       (4, 2, 'active'), -- clopez en DB201
       (5, 1, 'active'), -- lmartinez en CS101
       (5, 3, 'active'), -- lmartinez en WEB301
       (6, 2, 'active'), -- psanchez en DB201
       (6, 3, 'active');
-- psanchez en WEB301

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
VALUES (1, -- Parcial 1 Java
        4, -- clopez
        1,
        75.00,
        '2026-04-03 10:30:00',
        80,
        'graded',
        'Buen manejo de los conceptos básicos. Revisar estructuras de control.'),
       (1, -- Parcial 1 Java
        5, -- lmartinez
        1,
        55.00,
        '2026-04-04 14:00:00',
        88,
        'graded',
        'Necesita reforzar el concepto de métodos y su alcance.'),
       (1, -- Parcial 1 Java (segundo intento de lmartinez)
        5,
        2,
        72.00,
        '2026-04-06 16:00:00',
        75,
        'graded',
        'Mejoró notablemente. Aprobado.'),
       (3, -- Parcial 1 SQL
        6, -- psanchez
        1,
        88.00,
        '2026-04-02 11:00:00',
        55,
        'graded',
        'Excelente dominio de SQL. Muy buenos resultados en JOINs.');