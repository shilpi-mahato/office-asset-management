-- V1: create all tables (run by Flyway on startup)
-- 1. users: everyone who logs in (ADMIN, MANAGER, EMPLOYEE)
CREATE TABLE users (
    user_id     BIGINT AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(50)  NOT NULL UNIQUE,
    email       VARCHAR(100) NOT NULL UNIQUE,
    password    VARCHAR(100) NOT NULL,          -- BCrypt hash, never plain text
    role        ENUM('ADMIN','MANAGER','EMPLOYEE') NOT NULL,
    manager_id  BIGINT NULL,                    -- the employee's manager (a user)
    CONSTRAINT fk_users_manager FOREIGN KEY (manager_id) REFERENCES users(user_id)
);

-- 2. asset_categories: types of equipment (Laptop, Monitor, ...)
CREATE TABLE asset_categories (
    category_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
    category_name  VARCHAR(50) NOT NULL UNIQUE
);

-- 3. assets: the real physical items
CREATE TABLE assets (
    asset_id       BIGINT AUTO_INCREMENT PRIMARY KEY,
    serial_number  VARCHAR(50) NOT NULL UNIQUE,
    status         ENUM('AVAILABLE','ALLOCATED','DAMAGED') NOT NULL,
    category_id    BIGINT NOT NULL,
    CONSTRAINT fk_assets_category FOREIGN KEY (category_id) REFERENCES asset_categories(category_id)
);

-- 4. asset_requests: what employees ask for
CREATE TABLE asset_requests (
    request_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
    employee_id   BIGINT NOT NULL,
    category_id   BIGINT NOT NULL,
    reason        VARCHAR(200) NOT NULL,
    status        ENUM('PENDING','APPROVED','REJECTED','ALLOCATED','RETURN_REQUESTED','RETURNED') NOT NULL,
    requested_at  DATETIME NOT NULL,
    CONSTRAINT fk_requests_employee FOREIGN KEY (employee_id) REFERENCES users(user_id),
    CONSTRAINT fk_requests_category FOREIGN KEY (category_id) REFERENCES asset_categories(category_id)
);

-- 5. approvals: the manager's decision on a request (one decision per request)
CREATE TABLE approvals (
    approval_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
    request_id     BIGINT NOT NULL UNIQUE,
    manager_id     BIGINT NOT NULL,             -- the manager who decided
    decision       ENUM('APPROVED','REJECTED') NOT NULL,
    comment        VARCHAR(200) NULL,
    decision_date  DATETIME NOT NULL,
    CONSTRAINT fk_approvals_request FOREIGN KEY (request_id) REFERENCES asset_requests(request_id),
    CONSTRAINT fk_approvals_manager FOREIGN KEY (manager_id) REFERENCES users(user_id)
);

-- 6. allocation_history: who held which asset, and when
CREATE TABLE allocation_history (
    allocation_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
    asset_id       BIGINT NOT NULL,
    request_id     BIGINT NOT NULL UNIQUE,      -- one allocation per request
    employee_id    BIGINT NOT NULL,
    allocated_at   DATETIME NOT NULL,
    returned_at    DATETIME NULL,               -- empty until the asset comes back
    CONSTRAINT fk_history_asset    FOREIGN KEY (asset_id)    REFERENCES assets(asset_id),
    CONSTRAINT fk_history_request  FOREIGN KEY (request_id)  REFERENCES asset_requests(request_id),
    CONSTRAINT fk_history_employee FOREIGN KEY (employee_id) REFERENCES users(user_id)
);
