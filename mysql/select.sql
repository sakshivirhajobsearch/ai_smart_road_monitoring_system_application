use ai_smart_road_monitoring_system_application;

-- ============================
-- SELECT ALL TABLES
-- ============================

SELECT * FROM role;
SELECT * FROM user;

SELECT * FROM road_data;
SELECT * FROM pothole;
SELECT * FROM repair_activity;

-- ============================
-- JOINS FOR DASHBOARD
-- ============================

-- Potholes with road info
SELECT p.id, r.location, p.latitude, p.longitude, p.severity, p.detected_at
FROM pothole p
JOIN road_data r ON p.road_id = r.id;

-- Repair Activity with pothole mapping
SELECT ra.id, ra.status, ra.repaired_by, p.severity, r.location
FROM repair_activity ra
JOIN pothole p ON ra.pothole_id = p.id
JOIN road_data r ON p.road_id = r.id;
