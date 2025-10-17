package com.ai.smart.road.monitoring.system.application.gui;

import java.util.List;
import java.util.Map;

import com.ai.smart.road.monitoring.system.application.dto.PotholeResponse;
import com.ai.smart.road.monitoring.system.application.dto.RoadDataDTO;
import com.fasterxml.jackson.core.type.TypeReference;

public class SmartRoadDashboard {

	private final DataVisualizer visualizer;

	public SmartRoadDashboard() {
		this.visualizer = new DataVisualizer();
	}

	public void launchDashboard() {
		// Load all JSON files from classpath
		List<PotholeResponse> potholes = visualizer.loadJson("potholes_data.json",
				new TypeReference<List<PotholeResponse>>() {
				});
		List<RoadDataDTO> roads = visualizer.loadJson("road_data.json", new TypeReference<List<RoadDataDTO>>() {
		});
		Map<String, Object> summary = visualizer.loadJson("dashboard_data.json",
				new TypeReference<Map<String, Object>>() {
				});

		if (potholes == null)
			potholes = List.of();
		if (roads == null)
			roads = List.of();

		System.out.println("=== SMART ROAD MONITORING DASHBOARD ===");
		System.out.println("Total Roads: " + roads.size());
		System.out.println("Total Potholes Detected: " + potholes.size());

		visualizer.initializeWithData(roads, potholes, summary);
		visualizer.showVisualizer();
	}

	public static void main(String[] args) {
		new SmartRoadDashboard().launchDashboard();
	}
}
