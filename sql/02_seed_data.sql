-- ============================================================
-- Campus Skill Connect — Sample Seed Data
-- Run this AFTER 01_create_db.sql
-- Adds sample institutions and campuses for demonstration.
-- ============================================================

USE campus_skill_connect;

-- ============================================================
-- Sample Institutions (Colleges / Universities)
-- You can add your own institution here.
-- ============================================================
INSERT INTO institutions (name, city, state) VALUES
    ('National Institute of Technology', 'Calicut', 'Kerala'),
    ('Government Engineering College', 'Thrissur', 'Kerala'),
    ('College of Engineering', 'Trivandrum', 'Kerala'),
    ('Rajagiri School of Engineering', 'Kochi', 'Kerala'),
    ('St. Joseph''s College of Engineering', 'Chennai', 'Tamil Nadu');

-- ============================================================
-- Sample Campuses / Departments
-- Each campus belongs to an institution (institution_id).
-- ============================================================

-- Campuses for Institution 1: NIT Calicut
INSERT INTO campuses (institution_id, name, address) VALUES
    (1, 'Main Campus', 'NIT Campus, Chathamangalam, Calicut'),
    (1, 'Department of Computer Science', 'NIT Calicut'),
    (1, 'Department of Electronics', 'NIT Calicut');

-- Campuses for Institution 2: GEC Thrissur
INSERT INTO campuses (institution_id, name, address) VALUES
    (2, 'Main Campus', 'Ramavarmapuram, Thrissur'),
    (2, 'MCA Department', 'GEC Thrissur');

-- Campuses for Institution 3: College of Engineering, TVM
INSERT INTO campuses (institution_id, name, address) VALUES
    (3, 'Main Campus', 'Sreekaryam, Trivandrum'),
    (3, 'School of Computer Science', 'CET Trivandrum');

-- Campuses for Institution 4: Rajagiri
INSERT INTO campuses (institution_id, name, address) VALUES
    (4, 'Valley Campus', 'Kakkanad, Kochi'),
    (4, 'Hill Campus', 'Angamaly, Kochi');

-- Campuses for Institution 5: St. Joseph's
INSERT INTO campuses (institution_id, name, address) VALUES
    (5, 'Main Campus', 'OMR, Semmancheri, Chennai'),
    (5, 'Department of IT', 'St. Joseph''s, Chennai');

-- ============================================================
-- Sample Users (Students)
-- Password for all sample users: password123 (stored as BCrypt hash)
-- ============================================================
INSERT INTO users (email, password_hash, first_name, last_name, institution_id, campus_id, course, year_of_study, bio) VALUES
    ('rahul.sharma@nitc.ac.in', '$2a$12$8K1p/a0dL1LXMIgoEDZwV.p1mGf.Z7w/aGv4W3E6oO/2Oq5R5jV0G', 'Rahul', 'Sharma', 1, 2, 'MCA', 2, 'Enthusiastic Java & Web Developer looking to learn Python & AI.'),
    ('ananya.nair@gec.ac.in', '$2a$12$8K1p/a0dL1LXMIgoEDZwV.p1mGf.Z7w/aGv4W3E6oO/2Oq5R5jV0G', 'Ananya', 'Nair', 2, 5, 'MCA', 1, 'UI/UX Designer and Frontend developer. Passionate about Figma and React.'),
    ('arjun.kumar@cet.ac.in', '$2a$12$8K1p/a0dL1LXMIgoEDZwV.p1mGf.Z7w/aGv4W3E6oO/2Oq5R5jV0G', 'Arjun', 'Kumar', 3, 7, 'B.Tech CS', 3, 'Backend developer specializing in Spring Boot, MySQL, and Data Structures.')
ON DUPLICATE KEY UPDATE password_hash = VALUES(password_hash);




-- ============================================================
-- Sample Skills for Users
-- ============================================================
INSERT INTO skills (user_id, skill_name, proficiency_level, description) VALUES
    (1, 'Java Programming', 'ADVANCED', 'Core Java, OOP, Servlets, JDBC, Maven development.'),
    (1, 'SQL & MySQL', 'INTERMEDIATE', 'Database design, complex queries, indexing and optimization.'),
    (2, 'UI/UX Design', 'ADVANCED', 'Wireframing, prototyping in Figma, visual hierarchy and design systems.'),
    (2, 'HTML/CSS/JavaScript', 'INTERMEDIATE', 'Modern responsive web development with CSS grid and flexbox.'),
    (3, 'Data Structures & Algorithms', 'ADVANCED', 'Trees, Graphs, Dynamic Programming in C++ and Java.'),
    (3, 'Spring Boot', 'INTERMEDIATE', 'REST API creation, Spring Security, Hibernate ORM.');

-- ============================================================
-- Verify: Check inserted data
-- ============================================================
SELECT 'Institutions:' AS info;
SELECT id, name, city, state FROM institutions;

SELECT 'Users:' AS info;
SELECT id, email, first_name, last_name, course FROM users;

SELECT 'Skills:' AS info;
SELECT id, user_id, skill_name, proficiency_level FROM skills;

