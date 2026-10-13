-- ============================================================
-- Campus Skill Connect — Full Database Reset & Reseed
-- Run this in MySQL to restore all data to its clean state.
--
-- This script:
--   1. Drops all existing data (in correct FK order)
--   2. Re-inserts all institutions, campuses, users, and skills
--
-- Login credentials for all sample users:
--   Password: password123
-- ============================================================

USE campus_skill_connect;

-- Disable FK checks so we can truncate in any order
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE skill_requests;
TRUNCATE TABLE skills;
TRUNCATE TABLE users;
TRUNCATE TABLE campuses;
TRUNCATE TABLE institutions;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- Institutions
-- ============================================================
INSERT INTO institutions (id, name, city, state) VALUES
    (1, 'National Institute of Technology', 'Calicut', 'Kerala'),
    (2, 'Government Engineering College', 'Thrissur', 'Kerala'),
    (3, 'College of Engineering', 'Trivandrum', 'Kerala'),
    (4, 'Rajagiri School of Engineering', 'Kochi', 'Kerala'),
    (5, 'St. Joseph''s College of Engineering', 'Chennai', 'Tamil Nadu');

-- ============================================================
-- Campuses
-- ============================================================

-- NIT Calicut
INSERT INTO campuses (id, institution_id, name, address) VALUES
    (1, 1, 'Main Campus', 'NIT Campus, Chathamangalam, Calicut'),
    (2, 1, 'Department of Computer Science', 'NIT Calicut'),
    (3, 1, 'Department of Electronics', 'NIT Calicut');

-- GEC Thrissur
INSERT INTO campuses (id, institution_id, name, address) VALUES
    (4, 2, 'Main Campus', 'Ramavarmapuram, Thrissur'),
    (5, 2, 'MCA Department', 'GEC Thrissur');

-- College of Engineering, TVM
INSERT INTO campuses (id, institution_id, name, address) VALUES
    (6, 3, 'Main Campus', 'Sreekaryam, Trivandrum'),
    (7, 3, 'School of Computer Science', 'CET Trivandrum');

-- Rajagiri
INSERT INTO campuses (id, institution_id, name, address) VALUES
    (8, 4, 'Valley Campus', 'Kakkanad, Kochi'),
    (9, 4, 'Hill Campus', 'Angamaly, Kochi');

-- St. Joseph's
INSERT INTO campuses (id, institution_id, name, address) VALUES
    (10, 5, 'Main Campus', 'OMR, Semmancheri, Chennai'),
    (11, 5, 'Department of IT', 'St. Joseph''s, Chennai');

-- ============================================================
-- Users (Students)
-- Password for ALL users: password123 (stored as BCrypt hash)
-- ============================================================
INSERT INTO users (id, email, password_hash, first_name, last_name, institution_id, campus_id, course, year_of_study, bio) VALUES
    (1, 'rahul.sharma@nitc.ac.in',   '$2a$12$8K1p/a0dL1LXMIgoEDZwV.p1mGf.Z7w/aGv4W3E6oO/2Oq5R5jV0G', 'Rahul',  'Sharma', 1, 2, 'MCA',        2, 'Enthusiastic Java & Web Developer looking to learn Python & AI.'),
    (2, 'ananya.nair@gec.ac.in',     '$2a$12$8K1p/a0dL1LXMIgoEDZwV.p1mGf.Z7w/aGv4W3E6oO/2Oq5R5jV0G', 'Ananya', 'Nair',   2, 5, 'MCA',        1, 'UI/UX Designer and Frontend developer. Passionate about Figma and React.'),
    (3, 'arjun.kumar@cet.ac.in',     '$2a$12$8K1p/a0dL1LXMIgoEDZwV.p1mGf.Z7w/aGv4W3E6oO/2Oq5R5jV0G', 'Arjun',  'Kumar',  3, 7, 'B.Tech CS',  3, 'Backend developer specializing in Spring Boot, MySQL, and Data Structures.'),
    (4, 'priya.menon@rajagiri.edu',   '$2a$12$8K1p/a0dL1LXMIgoEDZwV.p1mGf.Z7w/aGv4W3E6oO/2Oq5R5jV0G', 'Priya',  'Menon',  4, 8, 'MCA',        2, 'Full-stack developer with a passion for React and Node.js.'),
    (5, 'deepak.raj@stjosephs.ac.in', '$2a$12$8K1p/a0dL1LXMIgoEDZwV.p1mGf.Z7w/aGv4W3E6oO/2Oq5R5jV0G', 'Deepak', 'Raj',    5, 10, 'B.Tech IT', 4, 'Machine Learning enthusiast and Python developer.');

-- ============================================================
-- Skills
-- ============================================================
INSERT INTO skills (id, user_id, skill_name, proficiency_level, description) VALUES
    -- Rahul's skills
    (1, 1, 'Java Programming',              'ADVANCED',      'Core Java, OOP, Servlets, JDBC, Maven development.'),
    (2, 1, 'SQL & MySQL',                    'INTERMEDIATE',  'Database design, complex queries, indexing and optimization.'),
    (3, 1, 'Web Development',                'INTERMEDIATE',  'HTML, CSS, JavaScript, JSP, and Servlet-based web apps.'),

    -- Ananya's skills
    (4, 2, 'UI/UX Design',                   'ADVANCED',      'Wireframing, prototyping in Figma, visual hierarchy and design systems.'),
    (5, 2, 'HTML/CSS/JavaScript',             'INTERMEDIATE',  'Modern responsive web development with CSS grid and flexbox.'),
    (6, 2, 'React',                           'BEGINNER',      'Component-based architecture, hooks, and state management.'),

    -- Arjun's skills
    (7, 3, 'Data Structures & Algorithms',    'ADVANCED',      'Trees, Graphs, Dynamic Programming in C++ and Java.'),
    (8, 3, 'Spring Boot',                     'INTERMEDIATE',  'REST API creation, Spring Security, Hibernate ORM.'),
    (9, 3, 'Python',                          'BEGINNER',      'Scripting, data analysis with pandas and NumPy.'),

    -- Priya's skills
    (10, 4, 'React',                          'ADVANCED',      'Full-stack React with Redux, Next.js, and TypeScript.'),
    (11, 4, 'Node.js',                        'INTERMEDIATE',  'Express.js, REST APIs, MongoDB integration.'),
    (12, 4, 'Figma',                          'INTERMEDIATE',  'UI prototyping, component libraries, and design tokens.'),

    -- Deepak's skills
    (13, 5, 'Python',                         'ADVANCED',      'Python for ML, data science, Flask, and automation.'),
    (14, 5, 'Machine Learning',               'INTERMEDIATE',  'Supervised/unsupervised learning, scikit-learn, TensorFlow basics.'),
    (15, 5, 'Git & GitHub',                   'INTERMEDIATE',  'Version control, branching strategies, pull request workflows.');

-- ============================================================
-- Sample Skill Requests
-- ============================================================
INSERT INTO skill_requests (from_user_id, to_user_id, skill_id, message, status) VALUES
    (1, 2, 4, 'Hi Ananya! I want to learn UI/UX Design. Can you help me get started with Figma?', 'PENDING'),
    (2, 3, 8, 'Hi Arjun! I need help understanding Spring Boot for my project. Can we connect?', 'ACCEPTED'),
    (3, 1, 1, 'Hi Rahul! Can you teach me advanced Java concepts like multithreading?', 'PENDING');

-- ============================================================
-- Verify data
-- ============================================================
SELECT '--- Institutions ---' AS info;
SELECT id, name, city FROM institutions;

SELECT '--- Campuses ---' AS info;
SELECT id, institution_id, name FROM campuses;

SELECT '--- Users ---' AS info;
SELECT id, email, first_name, last_name, course, year_of_study FROM users;

SELECT '--- Skills ---' AS info;
SELECT id, user_id, skill_name, proficiency_level FROM skills;

SELECT '--- Skill Requests ---' AS info;
SELECT id, from_user_id, to_user_id, skill_id, status FROM skill_requests;
