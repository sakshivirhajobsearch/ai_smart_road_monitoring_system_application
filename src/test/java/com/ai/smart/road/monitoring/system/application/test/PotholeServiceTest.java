package com.ai.smart.road.monitoring.system.application.test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.ai.smart.road.monitoring.system.application.model.Pothole;
import com.ai.smart.road.monitoring.system.application.service.PotholeService;

@SpringBootTest
public class PotholeServiceTest {

	@Autowired
	private PotholeService potholeService;

	@Test
	public void testCreateAndGetPothole() {
		// Create new pothole
		Pothole pothole = new Pothole();
		pothole.setLatitude(12.9716);
		pothole.setLongitude(77.5946);
		pothole.setDepth(0.3);
		pothole.setStatus("REPORTED");

		potholeService.createPothole(pothole);

		// Verify retrieval
		List<Pothole> potholes = potholeService.getAllPotholes();
		assertNotNull(potholes);
		assertEquals(1, potholes.size());
		assertEquals(0.3, potholes.get(0).getDepth());
	}

	@Test
	public void testUpdateAndDeletePothole() {
		Pothole pothole = new Pothole();
		pothole.setLatitude(12.9716);
		pothole.setLongitude(77.5946);
		pothole.setDepth(0.2);
		pothole.setStatus("REPORTED");
		Pothole saved = potholeService.createPothole(pothole);

		// Update
		saved.setDepth(0.5);
		potholeService.updatePothole(saved.getId(), saved);
		Pothole updated = potholeService.getPotholeById(saved.getId()).orElse(null);
		assertEquals(0.5, updated.getDepth());

		// Delete
		potholeService.deletePothole(saved.getId());
		List<Pothole> remaining = potholeService.getAllPotholes();
		assertEquals(0, remaining.size());
	}
}
