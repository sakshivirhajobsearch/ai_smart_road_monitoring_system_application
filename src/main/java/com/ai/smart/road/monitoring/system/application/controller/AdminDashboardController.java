package com.ai.smart.road.monitoring.system.application.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.smart.road.monitoring.system.application.dto.StatsDTO;

@Controller
@RequestMapping("/admin")
public class AdminDashboardController {

	@GetMapping("/dashboard")
	public String adminDashboard(Model model) {
		model.addAttribute("stats", new StatsDTO(120, 22, 12));
		return "admin-dashboard";
	}
}
