package com.ai.smart.road.monitoring.system.application.controller;

import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/dashboard")
public class DashboardController {
	
	@GetMapping("/summary")
	public Map<String, Object> summary() {
		return Map.of("potholes_today", 5, "repairs_pending", 2);
	}
}
