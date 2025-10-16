package com.ai.smart.road.monitoring.system.application.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.ai.smart.road.monitoring.system.application.dto.RoadDataDTO;
import com.ai.smart.road.monitoring.system.application.entity.RoadData;

@Service
public class DashboardService {

	// 🔹 Convert RoadData entity list to DTO list
	public List<RoadDataDTO> getRoadDataDTOs(List<RoadData> roadDataList) {
		return roadDataList.stream().map(r -> {
			RoadDataDTO dto = new RoadDataDTO();
			dto.setId(r.getX() + "_" + r.getY());
			dto.setLength(r.getLength());
			dto.setWidth(r.getWidth());
			dto.setHeight(r.getHeight());
			dto.setRecordedAt(r.getRecordedAt());
			dto.setLevelStatus(r.getLevelStatus());
			return dto;
		}).collect(Collectors.toList());
	}
}
