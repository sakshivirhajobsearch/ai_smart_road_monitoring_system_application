package com.ai.smart.road.monitoring.system.application.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

	@GetMapping("/dashboard")
	public String dashboard(Model model, Authentication auth) {
		String username = auth.getName();
		String role = auth.getAuthorities().stream().map(a -> a.getAuthority().replace("ROLE_", "")).findFirst()
				.orElse("USER");

		model.addAttribute("username", username);
		model.addAttribute("role", role);

		return "dashboard"; // Thymeleaf template
	}
}
