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

import com.ai.smart.road.monitoring.system.application.model.Pothole;
import com.ai.smart.road.monitoring.system.application.service.PotholeService;

@RestController
@RequestMapping("/api/potholes")
public class PotholeController {

	@Autowired
	private PotholeService potholeService;

	@GetMapping
	public List<Pothole> getAllPotholes() {
		return potholeService.getAllPotholes();
	}

	@GetMapping("/{id}")
	public ResponseEntity<Pothole> getPotholeById(@PathVariable Long id) {
		return potholeService.getPotholeById(id).map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
	}

	@PostMapping
	public Pothole createPothole(@RequestBody Pothole pothole) {
		return potholeService.createPothole(pothole);
	}

	@PutMapping("/{id}")
	public Pothole updatePothole(@PathVariable Long id, @RequestBody Pothole pothole) {
		return potholeService.updatePothole(id, pothole);
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Void> deletePothole(@PathVariable Long id) {
		potholeService.deletePothole(id);
		return ResponseEntity.noContent().build();
	}
}
