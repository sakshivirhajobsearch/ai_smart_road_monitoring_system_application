package com.ai.smart.road.monitoring.system.application.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

	@GetMapping("/admin/dashboard")
	public String adminDashboard() {
		return "admin-dashboard";
	}

	@GetMapping("/collector/dashboard")
	public String collectorDashboard() {
		return "collector-dashboard";
	}

	@GetMapping("/municipal/dashboard")
	public String municipalDashboard() {
		return "municipal-dashboard";
	}

	@GetMapping("/pwd/dashboard")
	public String pwdDashboard() {
		return "pwd-dashboard";
	}

	@GetMapping("/user/dashboard")
	public String userDashboard() {
		return "dashboard"; // default user dashboard
	}
}
