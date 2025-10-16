package com.ai.smart.road.monitoring.system.application.service;

import java.util.List;
import java.util.Optional;

import com.ai.smart.road.monitoring.system.application.entity.Pothole;

public interface PotholeService {
	List<Pothole> getAllPotholes();

	Optional<Pothole> getPotholeById(Long id);

	Pothole createPothole(Pothole pothole);

	Pothole updatePothole(Long id, Pothole pothole);

	void deletePothole(Long id);
}
