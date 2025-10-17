package com.ai.smart.road.monitoring.system.application.gui;

import java.util.List;

import javax.swing.JPanel;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.data.category.DefaultCategoryDataset;

import com.ai.smart.road.monitoring.system.application.dto.PotholeResponse;
import com.ai.smart.road.monitoring.system.application.dto.RoadDataDTO;

public class ChartGenerator {

	// Pothole depth chart
	public JPanel generatePotholeDepthChart(List<PotholeResponse> potholes, String title) {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		for (PotholeResponse p : potholes) {
			dataset.addValue(p.getDepth(), "Depth", "ID: " + p.getId());
		}
		JFreeChart chart = ChartFactory.createBarChart(title, "Pothole ID", "Depth (m)", dataset);
		return new ChartPanel(chart);
	}

	// Road dimension chart (Length, Width, SurfaceLevel as Height)
	public JPanel generateRoadDimensionsChart(List<RoadDataDTO> roads, String title) {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		for (RoadDataDTO r : roads) {
			dataset.addValue(r.getLength(), "Length", r.getId());
			dataset.addValue(r.getWidth(), "Width", r.getId());
			dataset.addValue(r.getHeight(), "Height", r.getId());
		}
		JFreeChart chart = ChartFactory.createBarChart(title, "Road Points", "Dimensions (m)", dataset);
		return new ChartPanel(chart);
	}
}
