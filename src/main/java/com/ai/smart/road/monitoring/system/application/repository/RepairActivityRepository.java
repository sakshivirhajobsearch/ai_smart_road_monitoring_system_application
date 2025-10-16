package com.ai.smart.road.monitoring.system.application.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ai.smart.road.monitoring.system.application.entity.RepairActivity;

public interface RepairActivityRepository extends JpaRepository<RepairActivity, Long> {
}
