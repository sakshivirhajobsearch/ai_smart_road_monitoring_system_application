package com.ai.smart.road.monitoring.system.application.controller;

import java.io.File;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.ai.smart.road.monitoring.system.application.gui.DataVisualizer;

/**
 * Spring MVC Dashboard controller used by web templates in /templates
 */
@Controller
public class DashboardController {

	private final DataVisualizer visualizer = new DataVisualizer();

	@GetMapping({ "/", "/dashboard" })
	public String dashboard(Model model) {
		File roadFile = new File("road_data.json");
		File potholeFile = new File("potholes_data.json");

		Map<String, Object> summary = visualizer.loadAndSummarize(roadFile, potholeFile);

		model.addAttribute("totalRoads", summary.getOrDefault("total_roads", 0));
		model.addAttribute("totalPotholes", summary.getOrDefault("total_potholes", 0));
		model.addAttribute("lastUpdated", summary.getOrDefault("last_updated", ""));

		// pass counts (maps) to template for rendering JS charts if needed
		model.addAttribute("severityCounts", summary.get("severity_counts"));
		model.addAttribute("conditionCounts", summary.get("condition_counts"));
		model.addAttribute("dailyTrend", summary.get("daily_trend"));

		return "dashboard"; // your dashboard.html
	}
}
