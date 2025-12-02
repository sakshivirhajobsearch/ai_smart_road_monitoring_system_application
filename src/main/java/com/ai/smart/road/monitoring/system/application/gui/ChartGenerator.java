package com.ai.smart.road.monitoring.system.application.gui;

import java.awt.Color;
import java.util.List;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

public class ChartGenerator {

	// ------------------ 1. PIE CHART: Pothole Severity ------------------
	public static JFreeChart createSeverityChart(List<DataVisualizer.Pothole> potholes) {

		DefaultPieDataset<String> dataset = new DefaultPieDataset<>();

		long high = potholes.stream().filter(p -> "HIGH".equalsIgnoreCase(p.severity)).count();
		long medium = potholes.stream().filter(p -> "MEDIUM".equalsIgnoreCase(p.severity)).count();
		long low = potholes.stream().filter(p -> "LOW".equalsIgnoreCase(p.severity)).count();

		dataset.setValue("High Severity", high);
		dataset.setValue("Medium Severity", medium);
		dataset.setValue("Low Severity", low);

		JFreeChart chart = ChartFactory.createPieChart("Pothole Severity Distribution", dataset, true, true, false);

		chart.getPlot().setBackgroundPaint(Color.LIGHT_GRAY);
		return chart;
	}

	// ------------------ 2. BAR CHART: Road Conditions ------------------
	public static JFreeChart createRoadConditionChart(List<DataVisualizer.Road> roads) {

		DefaultCategoryDataset dataset = new DefaultCategoryDataset();

		long good = roads.stream().filter(r -> "GOOD".equalsIgnoreCase(r.condition)).count();
		long moderate = roads.stream().filter(r -> "MODERATE".equalsIgnoreCase(r.condition)).count();
		long bad = roads.stream().filter(r -> "BAD".equalsIgnoreCase(r.condition)).count();

		dataset.addValue(good, "Roads", "Good");
		dataset.addValue(moderate, "Roads", "Moderate");
		dataset.addValue(bad, "Roads", "Bad");

		JFreeChart chart = ChartFactory.createBarChart("Road Condition Overview", "Condition", "Count", dataset);

		chart.getPlot().setBackgroundPaint(Color.LIGHT_GRAY);
		return chart;
	}

	// ------------------ 3. LINE CHART: Daily Detection Trend ------------------
	public static JFreeChart createPotholeTrendChart() {

		DefaultCategoryDataset dataset = new DefaultCategoryDataset();

		dataset.addValue(2, "Potholes", "Mon");
		dataset.addValue(3, "Potholes", "Tue");
		dataset.addValue(1, "Potholes", "Wed");
		dataset.addValue(4, "Potholes", "Thu");
		dataset.addValue(5, "Potholes", "Fri");

		JFreeChart chart = ChartFactory.createLineChart("Daily Detection Trend", "Day", "Potholes", dataset);

		chart.getPlot().setBackgroundPaint(Color.LIGHT_GRAY);
		return chart;
	}
}
