USE ai_smart_road_monitoring_system_application;

-- -------------------------
-- Insert ready-to-use users
-- Passwords are BCrypt hashes for:
-- admin123, collector123, pwd123, municipal123
-- -------------------------
-- Preloaded users with BCrypt passwords (passwords: admin123, collector123, pwd123, municipal123)
INSERT INTO users (username, password, role, enabled) VALUES
('admin', '$2a$10$O6ygRRE0YzXfAp3eOkUqkeXhSYEj4PGp2WKuTO6aw1TbVg.5kMJhC', 'ADMIN', true),
('collector', '$2a$10$HIDjGxH6T3KcZFm6eik5/.UePf23xTCr63V8ROkZl4K2BFX9TxQ6S', 'COLLECTOR', true),
('pwd', '$2a$10$WwNLJyd8aDshkGBxGHtHmeVb/xuvz3tV0UqGgL1I/NQjxi4a1u9aG', 'PWD', true),
('municipal', '$2a$10$4ABZHjsV7B0E5j/tmXKq4OqFX0H5a71CUMkaq8v0PM1X8tOaSlxaK', 'MUNICIPAL', true);

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
