USE ai_smart_road_monitoring_system_application;

-- ============================================================
-- UPDATE USER DETAILS
-- ============================================================
-- Disable a user
UPDATE users SET enabled = 0 WHERE username = 'collector';

-- Change role
UPDATE users SET role = 'ENGINEER' WHERE username = 'collector';

-- ============================================================
-- UPDATE POTHOLE DETAILS
-- ============================================================
UPDATE pothole
SET severity = 'CRITICAL'
WHERE id = 1;

-- Change image
UPDATE pothole
SET image_path = 'data/captured_images/pothole_updated.jpg'
WHERE id = 2;

-- ============================================================
-- UPDATE ROAD DATA
-- ============================================================
UPDATE road_data
SET status = 'UNDER_REPAIR', remarks = 'Repair in progress'
WHERE id = 1;

-- ============================================================
-- UPDATE REPAIR ACTIVITY
-- ============================================================
UPDATE repair_activity
SET status = 'COMPLETED',
    completed_at = NOW(),
    remarks = 'Repair completed successfully'
WHERE id = 1;
