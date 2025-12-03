USE ai_smart_road_monitoring_system_application;

-- ============================
-- ROLE TABLE
-- ============================
CREATE TABLE role (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- ============================
-- USER TABLE
-- ============================
CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(200) NOT NULL,
    enabled BOOLEAN DEFAULT TRUE,
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES role(id)
);

-- ============================
-- ROAD DATA TABLE
-- ============================
CREATE TABLE road_data (
    id INT PRIMARY KEY AUTO_INCREMENT,
    location VARCHAR(255),
    latitude DOUBLE,
    longitude DOUBLE,
    `condition` VARCHAR(50),      -- KEYWORD FIXED
    scanned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================
-- POTHOLE TABLE
-- ============================
CREATE TABLE pothole (
    id INT PRIMARY KEY AUTO_INCREMENT,
    road_id INT,
    latitude DOUBLE,
    longitude DOUBLE,
    severity VARCHAR(50),
    detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (road_id) REFERENCES road_data(id)
);

-- ============================
-- REPAIR ACTIVITY TABLE
-- ============================
CREATE TABLE repair_activity (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pothole_id INT,
    status VARCHAR(50),
    repaired_by VARCHAR(100),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pothole_id) REFERENCES pothole(id)
);
