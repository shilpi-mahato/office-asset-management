-- Asset Management POC: users table only (MySQL 8)
-- Use this while only the User entity exists.
-- Run first, then users_data.sql.

CREATE DATABASE IF NOT EXISTS asset_db;
USE asset_db;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
                       user_id     BIGINT AUTO_INCREMENT PRIMARY KEY,
                       username    VARCHAR(50)  NOT NULL UNIQUE,
                       email       VARCHAR(100) NOT NULL UNIQUE,
                       password    VARCHAR(100) NOT NULL,          -- BCrypt hash, never plain text
                       role        VARCHAR(20)  NOT NULL,          -- ADMIN / MANAGER / EMPLOYEE
                       manager_id  BIGINT NULL,                    -- the employee's manager (a user)
                       CONSTRAINT fk_users_manager FOREIGN KEY (manager_id) REFERENCES users(user_id)
);