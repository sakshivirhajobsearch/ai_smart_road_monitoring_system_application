USE ai_smart_road_monitoring_system_application;

-- Delete specific user
DELETE FROM user WHERE username = 'user1';

-- Delete pothole (cascades to repair_activity)
DELETE FROM pothole WHERE id = 1;

-- Delete single repair activity
DELETE FROM repair_activity WHERE id = 1;

-- Delete road data row
DELETE FROM road_data WHERE id = 1;

-- Delete an activity log entry
DELETE FROM activity_log WHERE id = 1;

-- Delete all logs
DELETE FROM activity_log;
