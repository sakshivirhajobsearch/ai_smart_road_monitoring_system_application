package com.ai.smart.road.monitoring.system.application.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

	@GetMapping("/dashboard")
	public String dashboardPage() {
		return "dashboard"; // templates/dashboard.html
	}
}
