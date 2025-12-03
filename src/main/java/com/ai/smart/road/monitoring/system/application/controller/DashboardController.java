package com.ai.smart.road.monitoring.system.application.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

	@GetMapping("/dashboard")
	public String dashboard(Authentication auth) {

		if (auth == null)
			return "redirect:/login";

		String role = auth.getAuthorities().iterator().next().getAuthority();

		switch (role) {
		case "ROLE_ADMIN":
			return "admin-dashboard";

		case "ROLE_MUNICIPAL":
			return "municipal-dashboard";

		case "ROLE_COLLECTOR":
			return "collector-dashboard";

		case "ROLE_PWD":
			return "pwd-dashboard";

		case "ROLE_USER":
			return "user-dashboard";

		default:
			return "redirect:/login";
		}
	}
}
