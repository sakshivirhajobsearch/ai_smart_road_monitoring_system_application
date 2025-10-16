package com.ai.smart.road.monitoring.system.application.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ai.smart.road.monitoring.system.application.entity.Pothole;
import com.ai.smart.road.monitoring.system.application.repository.PotholeRepository;

@Service
public class PotholeServiceImpl implements PotholeService {

	@Autowired
	private PotholeRepository potholeRepository;

	@Override
	public List<Pothole> getAllPotholes() {
		return potholeRepository.findAll();
	}

	@Override
	public Optional<Pothole> getPotholeById(Long id) {
		return potholeRepository.findById(id);
	}

	@Override
	public Pothole createPothole(Pothole pothole) {
		return potholeRepository.save(pothole);
	}

	@Override
	public Pothole updatePothole(Long id, Pothole potholeDetails) {
		return potholeRepository.findById(id).map(pothole -> {
			pothole.setLength(potholeDetails.getLength());
			pothole.setWidth(potholeDetails.getWidth());
			pothole.setDepth(potholeDetails.getDepth());
			pothole.setGpsLocation(potholeDetails.getGpsLocation()); // fixed
			pothole.setImagePath(potholeDetails.getImagePath()); // fixed
			pothole.setSeverity(potholeDetails.getSeverity());
			pothole.setDetectedDate(potholeDetails.getDetectedDate());
			pothole.setDetectedAt(potholeDetails.getDetectedAt());
			return potholeRepository.save(pothole);
		}).orElseThrow(() -> new RuntimeException("Pothole not found with id " + id));
	}

	@Override
	public void deletePothole(Long id) {
		potholeRepository.deleteById(id);
	}
}
