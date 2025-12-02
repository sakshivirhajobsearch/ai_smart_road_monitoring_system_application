USE ai_smart_road_monitoring_system_application;

-- ROLES
INSERT INTO role (name) VALUES
('ADMIN'), ('USER'), ('PWD'), ('COLLECTOR'), ('MUNICIPAL');

-- USERS (BCrypt password = admin123)
INSERT INTO user (username, password, enabled, role_id) VALUES
('admin',     '$2a$10$yZ8gQxqyR6mX1mBHSrLkeu6./zRHCqBzuxFJoPfU4rAqt1VTo95x2', TRUE, 1),
('user1',     '$2a$10$yZ8gQxqyR6mX1mBHSrLkeu6./zRHCqBzuxFJoPfU4rAqt1VTo95x2', TRUE, 2),
('pwd_user',  '$2a$10$yZ8gQxqyR6mX1mBHSrLkeu6./zRHCqBzuxFJoPfU4rAqt1VTo95x2', TRUE, 3),
('collector', '$2a$10$yZ8gQxqyR6mX1mBHSrLkeu6./zRHCqBzuxFJoPfU4rAqt1VTo95x2', TRUE, 4),
('municipal', '$2a$10$yZ8gQxqyR6mX1mBHSrLkeu6./zRHCqBzuxFJoPfU4rAqt1VTo95x2', TRUE, 5);

-- POTHOLE
INSERT INTO pothole (latitude, longitude, severity, image_path, detected_at, status)
VALUES (22.092, 82.150, 'HIGH', 'images/p1.jpg', NOW(), 'DETECTED');

-- REPAIR ACTIVITY
INSERT INTO repair_activity (pothole_id, repair_status, repaired_at, remarks)
VALUES (1, 'PENDING', NULL, 'Inspection needed');

-- ROAD DATA
INSERT INTO road_data (location, sensor_file, condition, analyzed_at)
VALUES ('Bilaspur', 'sensor/s1.csv', 'GOOD', NOW());

-- ACTIVITY LOG
INSERT INTO activity_log (action_type, description)
VALUES ('LOGIN', 'Admin logged in');
