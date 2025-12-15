package com.ai.smart.road.monitoring.system.application.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.ai.smart.road.monitoring.system.application.model.Pothole;

@Repository
public interface PotholeRepository extends JpaRepository<Pothole, Long> {

	/*
	 * ===================================================== BASIC COUNTS
	 * =====================================================
	 */
	long countByStatus(String status);

	/*
	 * ===================================================== SEVERITY DISTRIBUTION
	 * =====================================================
	 */
	@Query("""
			    SELECT p.severity, COUNT(p)
			    FROM Pothole p
			    GROUP BY p.severity
			""")
	List<Object[]> countBySeverity();

	/*
	 * ===================================================== DAILY DETECTION TREND
	 * =====================================================
	 */
	@Query("""
			    SELECT FUNCTION('DAYNAME', p.detectedAt), COUNT(p)
			    FROM Pothole p
			    WHERE p.detectedAt >= CURRENT_DATE - 6
			    GROUP BY FUNCTION('DAYNAME', p.detectedAt)
			    ORDER BY MIN(p.detectedAt)
			""")
	List<Object[]> dailyDetectionTrend();

	/*
	 * ===================================================== ROAD CONDITION (🔥
	 * FIXED) =====================================================
	 */
	@Query("""
			    SELECT p.roadId, COUNT(p)
			    FROM Pothole p
			    GROUP BY p.roadId
			""")
	List<Object[]> potholeCountPerRoad();
}
