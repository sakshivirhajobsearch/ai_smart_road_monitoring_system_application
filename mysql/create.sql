-- ============================================================
-- CREATE DATABASE
-- ============================================================
CREATE DATABASE IF NOT EXISTS ai_smart_road_monitoring_system_application
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE ai_smart_road_monitoring_system_application;

-- ============================================================
-- USERS TABLE
-- ============================================================
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    enabled TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ============================================================
-- POTHOLE TABLE
-- ============================================================
DROP TABLE IF EXISTS pothole;

CREATE TABLE pothole (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    image_path VARCHAR(255),
    gps_lat DOUBLE,
    gps_long DOUBLE,
    severity VARCHAR(50),
    detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ============================================================
-- ROAD DATA TABLE
-- ============================================================
DROP TABLE IF EXISTS road_data;

CREATE TABLE road_data (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(255),
    status VARCHAR(100),
    last_inspected TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    remarks TEXT
) ENGINE=InnoDB;

-- ============================================================
-- REPAIR ACTIVITY TABLE
-- ============================================================
-- Foreign key must be dropped BEFORE table recreation
DROP TABLE IF EXISTS repair_activity;

CREATE TABLE repair_activity (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    pothole_id BIGINT NOT NULL,
    assigned_to VARCHAR(100),
    status VARCHAR(50),
    started_at TIMESTAMP NULL,
    completed_at TIMESTAMP NULL,
    remarks TEXT,

    CONSTRAINT fk_pothole
      FOREIGN KEY (pothole_id)
      REFERENCES pothole(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- INDEXES
-- ============================================================
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_pothole_gps ON pothole(gps_lat, gps_long);
CREATE INDEX idx_road_status ON road_data(status);
CREATE INDEX idx_repair_status ON repair_activity(status);
