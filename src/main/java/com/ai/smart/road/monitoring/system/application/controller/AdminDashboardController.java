package com.ai.smart.road.monitoring.system.application.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.smart.road.monitoring.system.application.service.DashboardService;

@Controller
@RequestMapping("/admin")
public class AdminDashboardController {

	@Autowired
	private DashboardService dashboardService;

	@GetMapping("/dashboard")
	public String dashboard(Model model) {

		model.addAttribute("stats", dashboardService.getStats());

		return "admin-dashboard";
	}
}
