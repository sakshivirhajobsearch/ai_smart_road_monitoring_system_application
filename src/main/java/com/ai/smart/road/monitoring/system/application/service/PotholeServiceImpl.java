package com.ai.smart.road.monitoring.system.application.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ai.smart.road.monitoring.system.application.model.Pothole;
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
			pothole.setLatitude(potholeDetails.getLatitude());
			pothole.setLongitude(potholeDetails.getLongitude());
			pothole.setDepth(potholeDetails.getDepth());
			pothole.setWidth(potholeDetails.getWidth());
			pothole.setLength(potholeDetails.getLength());
			pothole.setImagePath(potholeDetails.getImagePath());
			return potholeRepository.save(pothole);
		}).orElseThrow(() -> new RuntimeException("Pothole not found with id " + id));
	}

	@Override
	public void deletePothole(Long id) {
		if (!potholeRepository.existsById(id)) {
			throw new RuntimeException("Pothole not found with id " + id);
		}
		potholeRepository.deleteById(id);
	}
}
