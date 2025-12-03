use ai_smart_road_monitoring_system_application;

-- ============================
-- DROP TABLES (correct order)
-- ============================

DROP TABLE IF EXISTS repair_activity;
DROP TABLE IF EXISTS pothole;
DROP TABLE IF EXISTS road_data;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS role;

-- ============================
-- CREATE TABLES
-- ============================

-- ----------------------------
-- ROLE TABLE
-- ----------------------------
CREATE TABLE role (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- ----------------------------
-- USER TABLE
-- ----------------------------
CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(200) NOT NULL,
    enabled BOOLEAN DEFAULT TRUE,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES role(id)
);

-- ----------------------------
-- ROAD DATA TABLE (condition keyword FIXED)
-- ----------------------------
CREATE TABLE road_data (
    id INT PRIMARY KEY AUTO_INCREMENT,
    location VARCHAR(255),
    latitude DOUBLE,
    longitude DOUBLE,
    `condition` VARCHAR(50),        -- FIXED (keyword wrapped in backticks)
    scanned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------
-- POTHOLE TABLE
-- ----------------------------
CREATE TABLE pothole (
    id INT PRIMARY KEY AUTO_INCREMENT,
    road_id INT,
    latitude DOUBLE,
    longitude DOUBLE,
    severity VARCHAR(50),
    detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (road_id) REFERENCES road_data(id)
);

-- ----------------------------
-- REPAIR ACTIVITY TABLE
-- ----------------------------
CREATE TABLE repair_activity (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pothole_id INT,
    status VARCHAR(50),
    repaired_by VARCHAR(100),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pothole_id) REFERENCES pothole(id)
);
