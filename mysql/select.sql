USE ai_smart_road_monitoring_system_application;

-- ============================================================
-- BASIC QUERIES
-- ============================================================
SELECT * FROM users;
SELECT * FROM pothole;
SELECT * FROM road_data;
SELECT * FROM repair_activity;

-- ============================================================
-- FILTERED QUERIES
-- ============================================================
-- Active users
SELECT username, role FROM users WHERE enabled = 1;

-- High-severity potholes
SELECT * FROM pothole WHERE severity IN ('HIGH', 'CRITICAL');

-- Repairs pending
SELECT * FROM repair_activity WHERE status = 'PENDING';

-- Roads requiring attention
SELECT * FROM road_data WHERE status IN ('DAMAGED', 'UNDER_REPAIR');

-- ============================================================
-- ANALYTICS (Dashboard queries)
-- ============================================================
-- Pothole count by severity
SELECT severity, COUNT(*) AS total
FROM pothole
GROUP BY severity;

-- Number of repairs by status
SELECT status, COUNT(*) AS total
FROM repair_activity
GROUP BY status;

-- Repairs with pothole details
SELECT r.id AS repair_id,
       p.id AS pothole_id,
       p.image_path,
       p.severity,
       r.assigned_to,
       r.status,
       r.started_at,
       r.completed_at
FROM repair_activity r
JOIN pothole p ON r.pothole_id = p.id
ORDER BY r.id DESC;

-- Road inspection summary
SELECT location, status, last_inspected
FROM road_data
ORDER BY last_inspected DESC;
