package com.ai.smart.road.monitoring.system.application.gui;

import java.util.List;

import javax.swing.SwingUtilities;

public class SmartRoadDashboardLauncher {
	
	public static void main(String[] args) {

		List<DataVisualizer.Road> roads = DataVisualizer.loadRoads("road_data.json");

		List<DataVisualizer.Pothole> potholes = DataVisualizer.loadPotholes("potholes_data.json");

		SwingUtilities.invokeLater(() -> {
			SmartRoadDashboard dashboard = new SmartRoadDashboard(roads, potholes);
			dashboard.setVisible(true);
		});
	}
}
