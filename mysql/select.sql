USE ai_smart_road_monitoring_system_application;

-- Get all users with roles
SELECT u.id, u.username, u.enabled, r.name AS role
FROM user u
LEFT JOIN role r ON u.role_id = r.id;

-- Get potholes
SELECT * FROM pothole;

-- Get repair activities with pothole info
SELECT 
    ra.id,
    ra.repair_status,
    ra.repaired_at,
    ra.remarks,
    p.latitude,
    p.longitude,
    p.status AS pothole_status
FROM repair_activity ra
JOIN pothole p ON ra.pothole_id = p.id;

-- Get road analysis data
SELECT * FROM road_data;

-- Get activity logs (latest first)
SELECT * FROM activity_log ORDER BY created_at DESC;

-- Dashboard statistics
SELECT 
    (SELECT COUNT(*) FROM pothole) AS total_potholes,
    (SELECT COUNT(*) FROM repair_activity WHERE repair_status = 'COMPLETED') AS total_repairs,
    (SELECT COUNT(*) FROM user) AS total_users;
