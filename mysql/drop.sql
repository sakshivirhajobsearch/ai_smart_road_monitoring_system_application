-- ===========================================
-- DROP DATABASE AND ALL TABLES (SAFE RESET)
-- ===========================================

DROP DATABASE IF EXISTS ai_smart_road_monitoring_system_application;

CREATE DATABASE ai_smart_road_monitoring_system_application;
USE ai_smart_road_monitoring_system_application;

-- DROP TABLES IN CORRECT ORDER
DROP TABLE IF EXISTS repair_activity;
DROP TABLE IF EXISTS pothole;
DROP TABLE IF EXISTS road_data;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS role;
