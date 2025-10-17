USE ai_smart_road_monitoring_system_application;

-- -------------------------
-- Insert ready-to-use users
-- Passwords are BCrypt hashes for:
-- admin123, collector123, pwd123, municipal123
-- -------------------------
-- Preloaded users with BCrypt passwords (passwords: admin123, collector123, pwd123, municipal123)
-- Preloaded users with plain text passwords (no encryption)
INSERT INTO users (username, password, role, enabled) VALUES
('admin', 'admin123', 'ADMIN', true),
('collector', 'collector123', 'COLLECTOR', true),
('pwd', 'pwd123', 'PWD', true),
('municipal', 'municipal123', 'MUNICIPAL', true);

-- Sample potholes
INSERT INTO pothole (road_name, latitude, longitude, depth, length, width, status) VALUES
('MG Road', 23.2599, 77.4126, 0.3, 2.0, 1.5, 'REPORTED'),
('Ring Road', 23.2670, 77.4000, 0.5, 1.5, 1.2, 'REPAIRED');

-- Sample road data
INSERT INTO road_data (road_name, latitude, longitude, surface_level, slope, status, sensor_file) VALUES
('MG Road', 23.2599, 77.4126, 0.02, 0.5, 'OK', 'mg_road_sensor.csv'),
('Ring Road', 23.2670, 77.4000, 0.03, 0.8, 'OK', 'ring_road_sensor.csv');

-- Sample repair activities
INSERT INTO repair_activity (pothole_id, activity_type, description, performed_by) VALUES
(1, 'FILL', 'Filled pothole with asphalt', 'Contractor A'),
(2, 'INSPECTION', 'Verified repair quality', 'Engineer B');
