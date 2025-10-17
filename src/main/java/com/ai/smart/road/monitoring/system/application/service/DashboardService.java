package com.ai.smart.road.monitoring.system.application.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.ai.smart.road.monitoring.system.application.dto.PotholeResponse;
import com.ai.smart.road.monitoring.system.application.dto.RoadDataDTO;
import com.ai.smart.road.monitoring.system.application.model.Pothole;
import com.ai.smart.road.monitoring.system.application.model.RoadData;

@Service
public class DashboardService {

	/**
	 * Convert list of RoadData entities into RoadDataDTOs
	 */
	public List<RoadDataDTO> toRoadDataDTOs(List<RoadData> roads) {
		return roads.stream()
				.map(r -> new RoadDataDTO(generateCompositeId(r.getLatitude(), r.getLongitude()), r.getSurfaceLevel(), // use
																														// surfaceLevel
																														// as
																														// "length"
						r.getSlope(), // use slope as "width"
						r.getSurfaceLevel(), // use surfaceLevel as "height"
						null, // recordedAt not tracked
						r.getLatitude(), r.getLongitude()))
				.collect(Collectors.toList());
	}

	/**
	 * Convert list of Pothole entities into PotholeResponse DTOs
	 */
	public List<PotholeResponse> toPotholeResponses(List<Pothole> potholes) {
		return potholes
				.stream().map(p -> new PotholeResponse(p.getId(), p.getLength(), p.getWidth(), p.getDepth(),
						p.getGpsLocation(), p.getDetectedAt(), p.getLatitude(), p.getLongitude()))
				.collect(Collectors.toList());
	}

	private String generateCompositeId(double latitude, double longitude) {
		return String.format("%.6f_%.6f", latitude, longitude);
	}
}
