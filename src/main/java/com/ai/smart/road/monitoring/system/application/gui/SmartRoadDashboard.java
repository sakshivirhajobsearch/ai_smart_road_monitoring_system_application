package com.ai.smart.road.monitoring.system.application.gui;

import java.util.List;

import com.ai.smart.road.monitoring.system.application.dto.PotholeResponse;
import com.ai.smart.road.monitoring.system.application.dto.RoadDataDTO;

public class SmartRoadDashboard {

	private final DataVisualizer visualizer;

	public SmartRoadDashboard() {
		this.visualizer = new DataVisualizer();
	}

	public void displayDashboard(List<RoadDataDTO> roads, List<PotholeResponse> potholes) {
		System.out.println("=== SMART ROAD MONITORING DASHBOARD ===");
		System.out.println("Total Roads: " + roads.size());
		System.out.println("Total Potholes Detected: " + potholes.size());

		// Visualize charts
		visualizer.visualizeRoadData(roads);
		visualizer.visualizePotholes(potholes);

		System.out.println("Charts and visualizations updated.");
	}
}
