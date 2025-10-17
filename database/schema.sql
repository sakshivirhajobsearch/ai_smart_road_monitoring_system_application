-- Create the database
CREATE DATABASE IF NOT EXISTS ai_smart_road_monitoring_system_application;
USE ai_smart_road_monitoring_system_application;

-- -------------------------
-- Table structure for users
-- -------------------------
-- Users table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    enabled BOOLEAN DEFAULT TRUE
);

-- -------------------------
-- Table structure for pothole
-- -------------------------
CREATE TABLE IF NOT EXISTS pothole (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    road_name VARCHAR(255) NOT NULL,
    latitude DOUBLE NOT NULL,
    longitude DOUBLE NOT NULL,
    depth DOUBLE NOT NULL,
    length DOUBLE NOT NULL,
    width DOUBLE NOT NULL,
    reported_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'REPORTED'
);

-- -------------------------
-- Table structure for road_data
-- -------------------------
CREATE TABLE IF NOT EXISTS road_data (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    road_name VARCHAR(255) NOT NULL,
    latitude DOUBLE NOT NULL,
    longitude DOUBLE NOT NULL,
    surface_level DOUBLE NOT NULL,
    slope DOUBLE DEFAULT 0,
    status VARCHAR(50) DEFAULT 'OK',
    sensor_file VARCHAR(255),
    recorded_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- -------------------------
-- Table structure for repair_activity
-- -------------------------
CREATE TABLE IF NOT EXISTS repair_activity (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    pothole_id BIGINT NOT NULL,
    activity_type VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    performed_by VARCHAR(255),
    performed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pothole_id) REFERENCES pothole(id) ON DELETE CASCADE
);
