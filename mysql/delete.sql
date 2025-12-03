USE ai_smart_road_monitoring_system_application;

-- DELETE A USER
DELETE FROM user WHERE username = 'user';

-- DELETE A POTHOLE
DELETE FROM pothole WHERE id = 2;

-- DELETE ROAD (CASCADE POTHOLES FIRST)
DELETE FROM pothole WHERE road_id = 1;
DELETE FROM road_data WHERE id = 1;

-- DELETE REPAIR LOG
DELETE FROM repair_activity WHERE id = 1;
