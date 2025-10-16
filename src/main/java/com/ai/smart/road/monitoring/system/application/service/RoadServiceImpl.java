package com.ai.smart.road.monitoring.system.application.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ai.smart.road.monitoring.system.application.entity.RoadData;
import com.ai.smart.road.monitoring.system.application.repository.RoadDataRepository;

@Service
public class RoadServiceImpl implements RoadService {

	@Autowired
	private RoadDataRepository roadDataRepository;

	@Override
	public List<RoadData> getAllRoads() {
		return roadDataRepository.findAll();
	}

	@Override
	public Optional<RoadData> getRoadById(Long id) {
		return roadDataRepository.findById(id);
	}

	@Override
	public RoadData createRoad(RoadData road) {
		return roadDataRepository.save(road);
	}

	@Override
	public RoadData updateRoad(Long id, RoadData roadDetails) {
		return roadDataRepository.findById(id).map(road -> {
			road.setLength(roadDetails.getLength());
			road.setWidth(roadDetails.getWidth());
			road.setHeight(roadDetails.getHeight());
			road.setLevelStatus(roadDetails.getLevelStatus());
			return roadDataRepository.save(road);
		}).orElseThrow(() -> new RuntimeException("Road not found with id " + id));
	}

	@Override
	public void deleteRoad(Long id) {
		roadDataRepository.deleteById(id);
	}
}
