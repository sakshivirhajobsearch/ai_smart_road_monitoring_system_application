USE ai_smart_road_monitoring_system_application;

-- Users and roles
SELECT u.id, u.username, r.name AS role
FROM user u
JOIN role r ON u.role_id = r.id;

-- All roads
SELECT * FROM road_data;

-- Potholes with road details
SELECT p.id, p.latitude, p.longitude, p.severity, r.location
FROM pothole p
JOIN road_data r ON p.road_id = r.id;

-- Repair logs with pothole info
SELECT ra.*, p.latitude, p.longitude
FROM repair_activity ra
JOIN pothole p ON ra.pothole_id = p.id;
