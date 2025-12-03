use ai_smart_road_monitoring_system_application;

-- ============================
-- DELETE USERS
-- ============================
DELETE FROM user WHERE username = 'user';

-- ============================
-- DELETE POTHOLE
-- ============================
DELETE FROM pothole WHERE id = 2;

-- ============================
-- DELETE ROAD RECORD
-- ============================
DELETE FROM road_data WHERE id = 3;

-- ============================
-- DELETE REPAIR ACTIVITY
-- ============================
DELETE FROM repair_activity WHERE id = 1;
