package com.ai.smart.road.monitoring.system.application.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ai.smart.road.monitoring.system.application.entity.Pothole;

@Repository
public interface PotholeRepository extends JpaRepository<Pothole, Long> {
}
