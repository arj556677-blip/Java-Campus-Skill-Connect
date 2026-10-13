-- ============================================================
-- Campus Skill Connect — Database Schema
-- Run this script in MySQL to create the database and tables.
-- ============================================================

-- Create the database (if it doesn't exist)
CREATE DATABASE IF NOT EXISTS campus_skill_connect
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Switch to the new database
USE campus_skill_connect;

-- ============================================================
-- Table 1: institutions
-- Stores colleges/universities. The system is multi-institution
-- by design — new colleges are added here as data rows.
-- ============================================================
CREATE TABLE IF NOT EXISTS institutions (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(200)  NOT NULL,
    city       VARCHAR(100),
    state      VARCHAR(100),
    created_at TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ============================================================
-- Table 2: campuses
-- Each institution can have multiple campuses/departments.
-- ============================================================
CREATE TABLE IF NOT EXISTS campuses (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    institution_id   INT           NOT NULL,
    name             VARCHAR(200)  NOT NULL,
    address          VARCHAR(500),
    created_at       TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,

    -- Foreign key: links each campus to an institution
    CONSTRAINT fk_campus_institution
        FOREIGN KEY (institution_id) REFERENCES institutions(id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- Table 3: users
-- Student accounts. Each student belongs to one institution
-- and one campus. Passwords are stored as bcrypt hashes.
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    email            VARCHAR(255)  NOT NULL UNIQUE,
    password_hash    VARCHAR(255)  NOT NULL,
    first_name       VARCHAR(100)  NOT NULL,
    last_name        VARCHAR(100)  NOT NULL,
    institution_id   INT           NOT NULL,
    campus_id        INT           NOT NULL,
    course           VARCHAR(200),
    year_of_study    INT,
    bio              TEXT,
    created_at       TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Foreign keys
    CONSTRAINT fk_user_institution
        FOREIGN KEY (institution_id) REFERENCES institutions(id),
    CONSTRAINT fk_user_campus
        FOREIGN KEY (campus_id) REFERENCES campuses(id)
) ENGINE=InnoDB;

-- ============================================================
-- Table 4: skills
-- Each student can list multiple skills with a proficiency level.
-- If a student is deleted, their skills are automatically removed.
-- ============================================================
CREATE TABLE IF NOT EXISTS skills (
    id                INT AUTO_INCREMENT PRIMARY KEY,
    user_id           INT           NOT NULL,
    skill_name        VARCHAR(150)  NOT NULL,
    proficiency_level ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED')
                      DEFAULT 'BEGINNER',
    description       TEXT,
    created_at        TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,

    -- Foreign key: links each skill to a user
    CONSTRAINT fk_skill_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- Table 5: skill_requests
-- Collaboration/exchange requests between students.
-- from_user sends a request to to_user about a specific skill.
-- ============================================================
CREATE TABLE IF NOT EXISTS skill_requests (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    from_user_id   INT           NOT NULL,
    to_user_id     INT           NOT NULL,
    skill_id       INT           NOT NULL,
    message        TEXT,
    status         ENUM('PENDING', 'ACCEPTED', 'REJECTED')
                   DEFAULT 'PENDING',
    created_at     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Foreign keys
    CONSTRAINT fk_request_from_user
        FOREIGN KEY (from_user_id) REFERENCES users(id),
    CONSTRAINT fk_request_to_user
        FOREIGN KEY (to_user_id) REFERENCES users(id),
    CONSTRAINT fk_request_skill
        FOREIGN KEY (skill_id) REFERENCES skills(id)
) ENGINE=InnoDB;

-- ============================================================
-- Index for faster skill-based search
-- ============================================================
CREATE INDEX idx_skill_name ON skills(skill_name);

-- Done! Run sql/02_seed_data.sql next to add sample data.
