USE ai_smart_road_monitoring_system_application;

-- Update user password
UPDATE user 
SET password = '$2a$10$yZ8gQxqyR6mX1mBHSrLkeu6./zRHCqBzuxFJoPfU4rAqt1VTo95x2'
WHERE username = 'admin';

-- Update pothole status
UPDATE pothole
SET status = 'IN_PROGRESS'
WHERE id = 1;

-- Update repair activity
UPDATE repair_activity
SET repair_status = 'COMPLETED',
    repaired_at = NOW(),
    remarks = 'Repaired successfully'
WHERE id = 1;

-- Update road data
UPDATE road_data
SET condition = 'DAMAGED'
WHERE id = 1;

-- Update activity log description
UPDATE activity_log
SET description = 'System updated by admin'
WHERE id = 1;
