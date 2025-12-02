package com.ai.smart.road.monitoring.system.application.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RoleRedirectController {

	@GetMapping("/role-redirect")
	public String redirect(Authentication auth) {

		String role = auth.getAuthorities().iterator().next().getAuthority();

		switch (role) {
		case "ADMIN":
			return "redirect:/admin-dashboard";
		case "PWD":
			return "redirect:/pwd-dashboard";
		case "COLLECTOR":
			return "redirect:/collector-dashboard";
		case "MUNICIPAL":
			return "redirect:/municipal-dashboard";
		case "USER":
		default:
			return "redirect:/dashboard";
		}
	}
}
