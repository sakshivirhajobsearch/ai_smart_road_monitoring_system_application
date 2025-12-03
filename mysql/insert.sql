USE ai_smart_road_monitoring_system_application;

-- ============================
-- INSERT ROLES
-- ============================
INSERT INTO role (name) VALUES
('ADMIN'),
('COLLECTOR'),
('MUNICIPAL'),
('PWD'),
('USER');

-- ============================
-- INSERT USERS (RAW PASSWORDS)
-- Replace with BCrypt hashes in real use
-- ============================
INSERT INTO user (username, password, enabled, role_id) VALUES
('admin', 'admin123', 1, 1),
('collector', 'collector123', 1, 2),
('municipal', 'municipal123', 1, 3),
('pwd', 'pwd123', 1, 4),
('user', 'user123', 1, 5);

-- ============================
-- INSERT SAMPLE ROAD DATA
-- ============================
INSERT INTO road_data (location, latitude, longitude, `condition`)
VALUES
('Road 1', 22.12345, 82.98765, 'GOOD'),
('Road 2', 22.54321, 82.12345, 'BAD'),
('Road 3', 22.67890, 82.54321, 'MODERATE');

-- ============================
-- INSERT SAMPLE POTHOLE DATA
-- ============================
INSERT INTO pothole (road_id, latitude, longitude, severity)
VALUES
(1, 22.12350, 82.98760, 'HIGH'),
(1, 22.12360, 82.98770, 'LOW'),
(2, 22.54325, 82.12350, 'MEDIUM');

-- ============================
-- INSERT SAMPLE REPAIR DATA
-- ============================
INSERT INTO repair_activity (pothole_id, status, repaired_by)
VALUES
(1, 'REPAIRED', 'PWD Team A'),
(2, 'PENDING', 'PWD Team C'),
(3, 'IN_PROGRESS', 'PWD Team B');
