package com.ai.smart.road.monitoring.system.application.gui;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridLayout;
import java.time.LocalDateTime;
import java.util.List;

import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;

public class SmartRoadDashboard extends JFrame {

	private final List<DataVisualizer.Road> roads;
	private final List<DataVisualizer.Pothole> potholes;

	public SmartRoadDashboard(List<DataVisualizer.Road> roads, List<DataVisualizer.Pothole> potholes) {

		this.roads = roads;
		this.potholes = potholes;

		setTitle("AI Smart Road Monitoring Dashboard");
		setSize(1400, 800);
		setLocationRelativeTo(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setLayout(new BorderLayout());

		addHeader();
		addCharts();
		addFooter();
	}

	private void addHeader() {
		JPanel header = new JPanel();
		header.setBackground(new Color(25, 35, 55));
		header.setPreferredSize(new Dimension(1400, 60));

		JLabel title = new JLabel("AI Smart Road Monitoring Dashboard");
		title.setForeground(Color.WHITE);
		title.setFont(new Font("Segoe UI", Font.BOLD, 22));

		header.add(title);
		add(header, BorderLayout.NORTH);
	}

	private void addCharts() {

		JPanel chartPanel = new JPanel(new GridLayout(1, 3, 10, 0));
		chartPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

		// Severity Chart
		JFreeChart severityChart = ChartGenerator.createSeverityChart(potholes);
		chartPanel.add(new ChartPanel(severityChart));

		// Road Condition Chart
		JFreeChart roadChart = ChartGenerator.createRoadConditionChart(roads);
		chartPanel.add(new ChartPanel(roadChart));

		// Daily Detection Trend
		JFreeChart trendChart = ChartGenerator.createPotholeTrendChart();
		chartPanel.add(new ChartPanel(trendChart));

		add(chartPanel, BorderLayout.CENTER);
	}

	private void addFooter() {

		JPanel footer = new JPanel(new GridLayout(1, 3));
		footer.setBackground(new Color(25, 35, 55));
		footer.setPreferredSize(new Dimension(1400, 80));

		JLabel totalRoads = new JLabel("  Total Roads\n" + roads.size());
		JLabel totalPotholes = new JLabel("  Potholes Detected\n" + potholes.size());
		JLabel updated = new JLabel("  Last Updated\n" + LocalDateTime.now());

		for (JLabel label : new JLabel[] { totalRoads, totalPotholes, updated }) {
			label.setForeground(Color.CYAN);
			label.setFont(new Font("Segoe UI", Font.BOLD, 16));
		}

		footer.add(totalRoads);
		footer.add(totalPotholes);
		footer.add(updated);

		add(footer, BorderLayout.SOUTH);
	}
}
