package com.ai.smart.road.monitoring.system.application.test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.ai.smart.road.monitoring.system.application.controller.RoadController;
import com.ai.smart.road.monitoring.system.application.model.RoadData;
import com.ai.smart.road.monitoring.system.application.service.RoadService;

@SpringBootTest
public class RoadControllerTest {

	@Autowired
	private RoadController roadController;

	@Autowired
	private RoadService roadService;

	@Test
	public void testCreateAndFetchRoad() {
		RoadData road = new RoadData();
		road.setLatitude(12.9716);
		road.setLongitude(77.5946);
		road.setSurfaceLevel(0.4);
		road.setSlope(0.02);
		road.setStatus("GOOD");
		roadService.createRoad(road);

		List<RoadData> roads = roadController.getAllRoads();
		assertNotNull(roads);
		assertEquals(1, roads.size());
		assertEquals(12.9716, roads.get(0).getLatitude());
	}

	@Test
	public void testUpdateAndDeleteRoad() {
		RoadData road = new RoadData();
		road.setLatitude(12.97);
		road.setLongitude(77.59);
		road.setSurfaceLevel(0.3);
		road.setSlope(0.01);
		road.setStatus("FAIR");
		RoadData saved = roadService.createRoad(road);

		// Update
		saved.setSurfaceLevel(0.6);
		roadService.updateRoad(saved.getId(), saved);
		RoadData updated = roadService.getRoadById(saved.getId()).orElse(null);
		assertEquals(0.6, updated.getSurfaceLevel());

		// Delete
		roadService.deleteRoad(saved.getId());
		List<RoadData> remaining = roadController.getAllRoads();
		assertEquals(0, remaining.size());
	}
}
