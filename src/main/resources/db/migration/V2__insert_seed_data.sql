-- V2: seed data (run by Flyway on startup, after V1)
--
-- Demo logins (passwords are stored as BCrypt hashes):
--   admin    / admin123      (ADMIN)
--   ravi     / manager123    (MANAGER, team: shilpi, meera)
--   kiran    / manager123    (MANAGER, team: arjun)
--   shilpi   / employee123   (EMPLOYEE, manager: ravi)
--   meera    / employee123   (EMPLOYEE, manager: ravi)
--   arjun    / employee123   (EMPLOYEE, manager: kiran)

-- ===== SECTION A: base data (needed to run the demo) =====

INSERT INTO users (user_id, username, email, password, role, manager_id) VALUES
(1, 'admin',  'admin@company.com',  '$2b$10$IrsdRsUXrHXyYdGxxBr4xOlibnczY6WbMTD3d27fkvr8NhKfSutle', 'ADMIN',    NULL),
(2, 'ravi',   'ravi@company.com',   '$2b$10$uRJfWTBJve0qu5YcCVgW6OJO6Lcq3OzNiLCyhpGZx9PAVDkUaaLgy', 'MANAGER',  NULL),
(3, 'kiran',  'kiran@company.com',  '$2b$10$uRJfWTBJve0qu5YcCVgW6OJO6Lcq3OzNiLCyhpGZx9PAVDkUaaLgy', 'MANAGER',  NULL),
(4, 'shilpi', 'shilpi@company.com', '$2b$10$AtF003Shi/eAL2GitJawv.qRoocsTR4UUU8gWyrK8Xe4Ts5eWnZ.G', 'EMPLOYEE', 2),
(5, 'meera',  'meera@company.com',  '$2b$10$AtF003Shi/eAL2GitJawv.qRoocsTR4UUU8gWyrK8Xe4Ts5eWnZ.G', 'EMPLOYEE', 2),
(6, 'arjun',  'arjun@company.com',  '$2b$10$AtF003Shi/eAL2GitJawv.qRoocsTR4UUU8gWyrK8Xe4Ts5eWnZ.G', 'EMPLOYEE', 3);

INSERT INTO asset_categories (category_id, category_name) VALUES
(1, 'Laptop'),
(2, 'Monitor'),
(3, 'Headset'),
(4, 'Mouse');

INSERT INTO assets (asset_id, serial_number, status, category_id) VALUES
(1, 'LAP-001', 'AVAILABLE', 1),
(2, 'LAP-002', 'AVAILABLE', 1),
(3, 'LAP-003', 'AVAILABLE', 1),
(4, 'MON-001', 'AVAILABLE', 2),
(5, 'MON-002', 'AVAILABLE', 2),
(6, 'HDS-001', 'AVAILABLE', 3),
(7, 'HDS-002', 'DAMAGED',   3),
(8, 'MOU-001', 'AVAILABLE', 4),
(9, 'MOU-002', 'AVAILABLE', 4);

-- ===== SECTION B: optional sample activity =====
-- Gives reports and history something to show right away.
-- Skip this section if you want to start with an empty request list.

INSERT INTO asset_requests (request_id, employee_id, category_id, reason, status, requested_at) VALUES
(1, 4, 1, 'Current laptop is too slow for development', 'ALLOCATED', '2026-11-02 10:00:00'),
(2, 5, 2, 'Need a second monitor for testing',           'PENDING',   '2026-11-20 09:15:00'),
(3, 6, 3, 'Want a new headset',                          'REJECTED',  '2026-11-10 11:00:00'),
(4, 5, 1, 'Temporary laptop for project work',           'RETURNED',  '2026-10-01 10:00:00');

-- Manager decisions (request 2 is still pending, so it has no approval row)
INSERT INTO approvals (approval_id, request_id, manager_id, decision, comment, decision_date) VALUES
(1, 1, 2, 'APPROVED', 'Approved',                           '2026-11-02 14:30:00'),
(2, 3, 3, 'REJECTED', 'Existing headset is still working',  '2026-11-11 09:00:00'),
(3, 4, 2, 'APPROVED', 'Approved',                           '2026-10-01 12:00:00');

INSERT INTO allocation_history (allocation_id, asset_id, request_id, employee_id, allocated_at, returned_at) VALUES
(1, 1, 1, 4, '2026-11-03 10:00:00', NULL),
(2, 2, 4, 5, '2026-10-02 10:00:00', '2026-11-01 16:00:00');

-- Keep asset status consistent with the history above
UPDATE assets SET status = 'ALLOCATED' WHERE asset_id = 1;
