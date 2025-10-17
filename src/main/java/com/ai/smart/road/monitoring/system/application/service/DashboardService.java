package com.ai.smart.road.monitoring.system.application.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.ai.smart.road.monitoring.system.application.dto.RoadDataDTO;
import com.ai.smart.road.monitoring.system.application.model.RoadData;

/**
 * DashboardService ---------------- This service converts raw RoadData entities
 * into RoadDataDTOs for dashboards and analytics.
 */
@Service
public class DashboardService {

	/**
	 * Convert list of RoadData entities into list of RoadDataDTOs.
	 *
	 * @param roadDataList list of raw RoadData entities
	 * @return list of RoadDataDTOs
	 */
	public List<RoadDataDTO> getRoadDataDTOs(List<RoadData> roadDataList) {
		if (roadDataList == null || roadDataList.isEmpty()) {
			return List.of();
		}

		return roadDataList.stream().map(r -> {
			RoadDataDTO dto = new RoadDataDTO();
			// Generate ID from latitude and longitude
			dto.setId(generateCompositeId(r.getLatitude(), r.getLongitude()));
			dto.setLength(r.getSurfaceLevel()); // map surfaceLevel to length
			dto.setWidth(r.getSlope()); // map slope to width
			dto.setHeight(0); // height not available in entity
			dto.setRecordedAt(null); // recordedAt not available in entity
			dto.setLevelStatus(r.getStatus()); // map status
			return dto;
		}).collect(Collectors.toList());
	}

	/**
	 * Generate a composite ID based on latitude and longitude.
	 *
	 * @param lat latitude
	 * @param lon longitude
	 * @return composite ID string
	 */
	private String generateCompositeId(double lat, double lon) {
		return String.format("%.6f_%.6f", lat, lon);
	}
}
