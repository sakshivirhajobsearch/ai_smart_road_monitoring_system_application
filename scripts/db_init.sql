CREATE DATABASE IF NOT EXISTS ai_smart_road_db;
USE ai_smart_road_db;
-- simple table stubs
CREATE TABLE IF NOT EXISTS pothole (id BIGINT AUTO_INCREMENT PRIMARY KEY, length DOUBLE, width DOUBLE, depth DOUBLE, image_path VARCHAR(512), gps_coordinates VARCHAR(128), detected_at TIMESTAMP);
