USE ai_smart_road_monitoring_system_application;

-- ============================================================
-- DELETE USER
-- ============================================================
DELETE FROM users WHERE username = 'collector';

-- ============================================================
-- DELETE POTHOLE (CASCADE deletes repair_activity)
-- ============================================================
DELETE FROM pothole WHERE id = 2;

-- ============================================================
-- DELETE ROAD DATA
-- ============================================================
DELETE FROM road_data WHERE id = 1;

-- ============================================================
-- DELETE ONLY ONE REPAIR ACTIVITY
-- ============================================================
DELETE FROM repair_activity WHERE id = 1;
