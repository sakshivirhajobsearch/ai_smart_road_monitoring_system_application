USE ai_smart_road_monitoring_system_application;

-- ============================================================
-- CLEAN TABLES (order matters because of FK constraints)
-- ============================================================
DELETE FROM repair_activity;
DELETE FROM pothole;
DELETE FROM road_data;
DELETE FROM users;

-- ============================================================
-- INSERT SYSTEM USERS (BCrypt hashed passwords)
-- ============================================================
INSERT INTO users (username, password, role, enabled) VALUES
('admin',
 '$2b$12$.c5saNwIec9xoNUrnM9cW.cC3u9F8nt9Xh5QQm1YfYmCfl0YTIW8y',
 'ADMIN', 1),

('collector',
 '$2b$12$hWQGp6c3yRbo/.f1ZtQwF.u5mL4oFKVBvWBkA0BfJzCevQWheaGm6',
 'COLLECTOR', 1),

('engineer',
 '$2b$12$HqZV2IfAhqmtazQ2IgkO7.uGTD/oY1w6jlfeCpDYO6H6s.l5tPlAG',
 'ENGINEER', 1),

('municipal',
 '$2b$12$8zEjXjsVwTSe/SqD4L6uNezKfCxUTfqY6LoH7Qkq9lc3v9b7TVSQ6',
 'MUNICIPAL', 1);

-- ============================================================
-- SAMPLE POTHOLE DATA
-- ============================================================
INSERT INTO pothole (image_path, gps_lat, gps_long, severity)
VALUES
('data/captured_images/pothole_20251016_120301.jpg', 21.22345, 81.34567, 'HIGH'),
('data/captured_images/pothole_20251016_121015.jpg', 21.22888, 81.35555, 'MEDIUM');

-- ============================================================
-- SAMPLE ROAD DATA
-- ============================================================
INSERT INTO road_data (location, status, remarks)
VALUES
('Rajendra Nagar Main Road', 'DAMAGED', 'Large potholes detected'),
('Mission School Road', 'GOOD', 'Road condition stable and safe');

-- ============================================================
-- SAMPLE REPAIR ACTIVITIES
-- ============================================================
INSERT INTO repair_activity (pothole_id, assigned_to, status, remarks)
VALUES
(1, 'engineer', 'ASSIGNED', 'Repair order issued'),
(2, 'engineer', 'PENDING', 'Inspection scheduled');
