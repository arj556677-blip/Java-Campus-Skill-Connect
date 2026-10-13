-- ============================================================
-- Campus Skill Connect — Update Passwords to BCrypt Hashing
-- Run this script in MySQL to convert any plain-text passwords
-- to secure BCrypt hashes.
-- ============================================================

USE campus_skill_connect;

-- Update sample users whose password was set to plain text 'password123'
UPDATE users 
SET password_hash = '$2a$12$8K1p/a0dL1LXMIgoEDZwV.p1mGf.Z7w/aGv4W3E6oO/2Oq5R5jV0G'
WHERE password_hash = 'password123' OR password_hash NOT LIKE '$2a$%';

-- Verify that all users now have BCrypt hashed passwords (length >= 60, starting with $2a$)
SELECT id, email, first_name, last_name, LEFT(password_hash, 10) AS hash_prefix, CHAR_LENGTH(password_hash) AS hash_length 
FROM users;
