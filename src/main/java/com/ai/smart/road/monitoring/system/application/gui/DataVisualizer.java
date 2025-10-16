package com.ai.smart.road.monitoring.system.application.gui;

import java.awt.BorderLayout;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTabbedPane;
import javax.swing.SwingUtilities;

import com.ai.smart.road.monitoring.system.application.dto.PotholeResponse;
import com.ai.smart.road.monitoring.system.application.dto.RoadDataDTO;

public class DataVisualizer extends JFrame {

	private static final long serialVersionUID = 1L;
	
	private ChartGenerator chartGenerator;
	private JTabbedPane tabbedPane;

	// Default constructor
	public DataVisualizer() {
		super("Smart Road Monitoring Dashboard");
		this.chartGenerator = new ChartGenerator();

		// JFrame settings
		setSize(1000, 600);
		setLocationRelativeTo(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setLayout(new BorderLayout());

		tabbedPane = new JTabbedPane();
		add(tabbedPane, BorderLayout.CENTER);
	}

	// Method to visualize potholes
	public void visualizePotholes(List<PotholeResponse> potholes) {
		JPanel potholeChartPanel = chartGenerator.generatePotholeDepthChart(potholes, "Pothole Depth Chart");
		tabbedPane.addTab("Potholes", potholeChartPanel);
	}

	// Method to visualize road data
	public void visualizeRoadData(List<RoadDataDTO> roads) {
		JPanel roadChartPanel = chartGenerator.generateRoadDimensionsChart(roads, "Road Dimensions Chart");
		tabbedPane.addTab("Road Dimensions", roadChartPanel);
	}

	// Show the JFrame
	public void showVisualizer() {
		SwingUtilities.invokeLater(() -> setVisible(true));
	}

	// Example main method for testing
	public static void main(String[] args) {
		// Dummy data
		List<PotholeResponse> potholes = List.of(
				new PotholeResponse(1L, 1.2, 0.8, 0.3, "12.34,56.78", java.time.LocalDateTime.now()),
				new PotholeResponse(2L, 2.0, 1.0, 0.5, "12.35,56.79", java.time.LocalDateTime.now()));

		List<RoadDataDTO> roads = List.of(new RoadDataDTO("12.34_56.78", 10, 5, 0.2, java.time.LocalDateTime.now()),
				new RoadDataDTO("12.35_56.79", 12, 6, 0.1, java.time.LocalDateTime.now()));

		// Create visualizer
		DataVisualizer visualizer = new DataVisualizer();

		// Add charts
		visualizer.visualizePotholes(potholes);
		visualizer.visualizeRoadData(roads);

		// Show GUI
		visualizer.showVisualizer();
	}
}
