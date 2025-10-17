package com.ai.smart.road.monitoring.system.application.gui;

import java.awt.BorderLayout;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import javax.swing.JFrame;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.SwingUtilities;

import com.ai.smart.road.monitoring.system.application.dto.PotholeResponse;
import com.ai.smart.road.monitoring.system.application.dto.RoadDataDTO;
import com.ai.smart.road.monitoring.system.application.gui.components.PotholeMapPanel;
import com.ai.smart.road.monitoring.system.application.gui.components.RoadMapPanel;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class DataVisualizer extends JFrame {

	private static final long serialVersionUID = 1L;

	private JTabbedPane tabbedPane;
	private ChartGenerator chartGenerator;

	public DataVisualizer() {
		super("Smart Road Monitoring Dashboard");
		chartGenerator = new ChartGenerator();

		setSize(1000, 600);
		setLocationRelativeTo(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setLayout(new BorderLayout());

		tabbedPane = new JTabbedPane();
		add(tabbedPane, BorderLayout.CENTER);
	}

	/**
	 * Generic JSON loader using classpath resources
	 */
	public <T> T loadJson(String resourcePath, TypeReference<T> typeRef) {
		try (InputStream is = getClass().getClassLoader().getResourceAsStream(resourcePath)) {
			if (is == null) {
				System.err.println("Resource not found: " + resourcePath);
				return null;
			}
			ObjectMapper mapper = new ObjectMapper();
			return mapper.readValue(is, typeRef);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * Initialize GUI from JSON resources
	 */
	public void initialize() {
		// Load data from classpath
		List<PotholeResponse> potholes = loadJson("potholes_data.json", new TypeReference<List<PotholeResponse>>() {
		});
		List<RoadDataDTO> roads = loadJson("road_data.json", new TypeReference<List<RoadDataDTO>>() {
		});
		Map<String, Object> summary = loadJson("dashboard_data.json", new TypeReference<Map<String, Object>>() {
		});

		// Safety checks
		if (potholes == null)
			potholes = List.of();
		if (roads == null)
			roads = List.of();

		initializeWithData(roads, potholes, summary);
	}

	/**
	 * Initialize GUI with provided data and optional summary
	 */
	public void initializeWithData(List<RoadDataDTO> roads, List<PotholeResponse> potholes,
			Map<String, Object> summary) {
		tabbedPane.removeAll();

		// Maps
		tabbedPane.addTab("Potholes Map", new PotholeMapPanel(potholes));
		tabbedPane.addTab("Roads Map", new RoadMapPanel(roads));

		// Charts
		tabbedPane.addTab("Pothole Depth Chart", chartGenerator.generatePotholeDepthChart(potholes, "Pothole Depth"));
		tabbedPane.addTab("Road Dimensions Chart",
				chartGenerator.generateRoadDimensionsChart(roads, "Road Dimensions"));

		// Summary tab
		if (summary != null && !summary.isEmpty()) {
			JTextArea summaryArea = new JTextArea();
			summaryArea.setEditable(false);
			summary.forEach((k, v) -> summaryArea.append(k + ": " + v + "\n"));
			tabbedPane.addTab("Summary", summaryArea);
		}
	}

	public JTabbedPane getTabbedPane() {
		return tabbedPane;
	}

	public void showVisualizer() {
		SwingUtilities.invokeLater(() -> setVisible(true));
	}

	public static void main(String[] args) {
		DataVisualizer visualizer = new DataVisualizer();
		visualizer.initialize();
		visualizer.showVisualizer();
	}
}
