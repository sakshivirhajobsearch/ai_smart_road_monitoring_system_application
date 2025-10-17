package com.ai.smart.road.monitoring.system.application.test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.ai.smart.road.monitoring.system.application.dto.RoadDataDTO;
import com.ai.smart.road.monitoring.system.application.model.RoadData;
import com.ai.smart.road.monitoring.system.application.service.DashboardService;
import com.ai.smart.road.monitoring.system.application.service.RoadService;

@SpringBootTest
public class DashboardIntegrationTest {

	@Autowired
	private RoadService roadService;

	@Autowired
	private DashboardService dashboardService;

	@Test
	public void testGetRoadDataDTOs() {
		// Create dummy road
		RoadData road = new RoadData();
		road.setLatitude(12.9716);
		road.setLongitude(77.5946);
		road.setSurfaceLevel(0.5);
		road.setSlope(0.01);
		road.setStatus("GOOD");
		roadService.createRoad(road);

		// Fetch DTOs
		List<RoadDataDTO> dtos = dashboardService.getRoadDataDTOs(roadService.getAllRoads());
		assertNotNull(dtos);
		assertEquals(1, dtos.size());

		RoadDataDTO dto = dtos.get(0);
		assertEquals("12.971600_77.594600", dto.getId());
		assertEquals(0.5, dto.getLength());
	}
}
