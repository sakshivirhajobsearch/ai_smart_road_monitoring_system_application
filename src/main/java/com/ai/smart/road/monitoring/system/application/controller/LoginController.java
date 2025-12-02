package com.ai.smart.road.monitoring.system.application.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {

	@GetMapping({ "/", "/login" })
	public String login(Model model, String error, String logout) {

		if (error != null)
			model.addAttribute("errorMsg", "Invalid username or password.");

		if (logout != null)
			model.addAttribute("logoutMsg", "You have been logged out.");

		return "login";
	}
}
