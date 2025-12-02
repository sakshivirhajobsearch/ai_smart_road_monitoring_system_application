CREATE DATABASE IF NOT EXISTS ai_smart_road_monitoring_system_application
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ai_smart_road_monitoring_system_application;

-- ============================
-- ROLE TABLE
-- ============================
CREATE TABLE IF NOT EXISTS role (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- ============================
-- USER TABLE
-- ============================
CREATE TABLE IF NOT EXISTS user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    enabled BOOLEAN DEFAULT TRUE,
    role_id BIGINT,
    CONSTRAINT fk_user_role FOREIGN KEY (role_id)
        REFERENCES role(id)
        ON DELETE SET NULL
) ENGINE=InnoDB;

-- ============================
-- POTHOLE TABLE
-- ============================
CREATE TABLE IF NOT EXISTS pothole (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    latitude DOUBLE NOT NULL,
    longitude DOUBLE NOT NULL,
    severity VARCHAR(20),
    image_path VARCHAR(255),
    detected_at DATETIME,
    status VARCHAR(50)
) ENGINE=InnoDB;

-- ============================
-- REPAIR ACTIVITY TABLE
-- ============================
CREATE TABLE IF NOT EXISTS repair_activity (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    pothole_id BIGINT NOT NULL,
    repair_status VARCHAR(50),
    repaired_at DATETIME,
    remarks TEXT,
    CONSTRAINT fk_repair_pothole FOREIGN KEY (pothole_id)
        REFERENCES pothole(id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================
-- ROAD DATA TABLE
-- ============================
CREATE TABLE IF NOT EXISTS road_data (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    location VARCHAR(255),
    sensor_file VARCHAR(255),
    condition VARCHAR(100),
    analyzed_at DATETIME
) ENGINE=InnoDB;

-- ============================
-- ACTIVITY LOG TABLE
-- ============================
CREATE TABLE IF NOT EXISTS activity_log (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    action_type VARCHAR(100),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
