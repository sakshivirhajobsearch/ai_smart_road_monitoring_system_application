package com.ai.smart.road.monitoring.system.application.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ai.smart.road.monitoring.system.application.entity.RoadData;
import com.ai.smart.road.monitoring.system.application.service.RoadService;

@RestController
@RequestMapping("/api/roads")
public class RoadController {

	@Autowired
	private RoadService roadService;

	@GetMapping
	public List<RoadData> getAllRoads() {
		return roadService.getAllRoads();
	}

	@GetMapping("/{id}")
	public ResponseEntity<RoadData> getRoadById(@PathVariable Long id) {
		return roadService.getRoadById(id).map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
	}

	@PostMapping
	public RoadData createRoad(@RequestBody RoadData road) {
		return roadService.createRoad(road);
	}

	@PutMapping("/{id}")
	public RoadData updateRoad(@PathVariable Long id, @RequestBody RoadData road) {
		return roadService.updateRoad(id, road);
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Void> deleteRoad(@PathVariable Long id) {
		roadService.deleteRoad(id);
		return ResponseEntity.noContent().build();
	}
}
