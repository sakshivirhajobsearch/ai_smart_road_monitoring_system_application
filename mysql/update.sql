use ai_smart_road_monitoring_system_application;

-- ============================
-- UPDATE USER PASSWORD
-- ============================
UPDATE user SET password = '{noop}newpassword123' WHERE username = 'admin';

-- ============================
-- UPDATE ROAD CONDITION
-- ============================
UPDATE road_data
SET condition = 'NEEDS_INSPECTION'
WHERE id = 2;

-- ============================
-- UPDATE POTHOLE SEVERITY
-- ============================
UPDATE pothole
SET severity = 'CRITICAL'
WHERE id = 3;

-- ============================
-- UPDATE REPAIR STATUS
-- ============================
UPDATE repair_activity
SET status = 'COMPLETED', updated_at = CURRENT_TIMESTAMP
WHERE id = 2;
