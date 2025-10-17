package com.ai.smart.road.monitoring.system.application.controller;

import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/dashboard")
public class DashboardController {

	@GetMapping("/dashboard")
	public String dashboard(Model model, Authentication authentication) {
		model.addAttribute("username", authentication.getName());
		return "dashboard";
	}

	@GetMapping("/summary")
	public Map<String, Object> summary() {
		return Map.of("potholes_today", 5, "repairs_pending", 2);
	}

}
