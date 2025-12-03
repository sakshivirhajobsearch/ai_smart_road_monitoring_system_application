USE ai_smart_road_monitoring_system_application;

-- ============================
-- INSERT ROLES
-- ============================
INSERT INTO role (name) VALUES
('ADMIN'), ('COLLECTOR'), ('MUNICIPAL'), ('PWD'), ('USER');

-- ============================
-- INSERT USERS
-- ============================
INSERT INTO user (username, password, enabled, role_id) VALUES
('admin',     '{noop}admin123',     TRUE, 1),
('collector', '{noop}collector123', TRUE, 2),
('municipal', '{noop}municipal123', TRUE, 3),
('pwd',       '{noop}pwd123',       TRUE, 4),
('user',      '{noop}user123',      TRUE, 5);

-- ============================
-- INSERT ROADS  (Fixed keyword `condition`)
-- ============================
INSERT INTO road_data (location, latitude, longitude, `condition`) VALUES
('Main Road Sector 12',     22.0801, 82.1402, 'GOOD'),
('Bridge Road Zone 3',      22.0951, 82.1604, 'DAMAGED'),
('City Center Ring Road',   22.1101, 82.1755, 'MODERATE');

-- ============================
-- INSERT POTHOLES
-- ============================
INSERT INTO pothole (road_id, latitude, longitude, severity) VALUES
(1, 22.0805, 82.1408, 'LOW'),
(1, 22.0810, 82.1412, 'MEDIUM'),
(2, 22.0955, 82.1609, 'HIGH');

-- ============================
-- INSERT REPAIR ACTIVITY
-- ============================
INSERT INTO repair_activity (pothole_id, status, repaired_by) VALUES
(1, 'PENDING',      'Collector Team'),
(2, 'IN_PROGRESS',  'Municipal Team'),
(3, 'COMPLETED',    'PWD Department');
