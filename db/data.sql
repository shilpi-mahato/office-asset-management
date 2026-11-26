-- Asset Management POC: users INSERT script (MySQL 8)
-- Run AFTER users_schema.sql.
--
-- Demo logins (passwords are stored as BCrypt hashes):
--   admin    / admin123      (ADMIN)
--   ravi     / manager123    (MANAGER, team: shilpi, meera)
--   kiran    / manager123    (MANAGER, team: arjun)
--   shilpi   / employee123   (EMPLOYEE, manager: ravi)
--   meera    / employee123   (EMPLOYEE, manager: ravi)
--   arjun    / employee123   (EMPLOYEE, manager: kiran)

USE asset_db;

-- Managers and admin first, because employees point to them through manager_id.
INSERT INTO users (user_id, username, email, password, role, manager_id) VALUES
                                                                             (1, 'admin',  'admin@company.com',  '$2b$10$IrsdRsUXrHXyYdGxxBr4xOlibnczY6WbMTD3d27fkvr8NhKfSutle', 'ADMIN',    NULL),
                                                                             (2, 'ravi',   'ravi@company.com',   '$2b$10$uRJfWTBJve0qu5YcCVgW6OJO6Lcq3OzNiLCyhpGZx9PAVDkUaaLgy', 'MANAGER',  NULL),
                                                                             (3, 'kiran',  'kiran@company.com',  '$2b$10$uRJfWTBJve0qu5YcCVgW6OJO6Lcq3OzNiLCyhpGZx9PAVDkUaaLgy', 'MANAGER',  NULL),
                                                                             (4, 'shilpi', 'shilpi@company.com', '$2b$10$AtF003Shi/eAL2GitJawv.qRoocsTR4UUU8gWyrK8Xe4Ts5eWnZ.G', 'EMPLOYEE', 2),
                                                                             (5, 'meera',  'meera@company.com',  '$2b$10$AtF003Shi/eAL2GitJawv.qRoocsTR4UUU8gWyrK8Xe4Ts5eWnZ.G', 'EMPLOYEE', 2),
                                                                             (6, 'arjun',  'arjun@company.com',  '$2b$10$AtF003Shi/eAL2GitJawv.qRoocsTR4UUU8gWyrK8Xe4Ts5eWnZ.G', 'EMPLOYEE', 3);