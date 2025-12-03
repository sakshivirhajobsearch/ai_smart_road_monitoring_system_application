USE ai_smart_road_monitoring_system_application;

-- UPDATE USER PASSWORD
UPDATE user SET password = 'newPassword' WHERE username = 'user';

-- UPDATE ROAD CONDITION
UPDATE road_data SET `condition` = 'GOOD'
WHERE id = 2;

-- UPDATE POTHOLE STATUS
UPDATE pothole SET severity = 'LOW'
WHERE id = 1;

-- UPDATE REPAIR ACTIVITY
UPDATE repair_activity SET status = 'COMPLETED'
WHERE id = 2;
