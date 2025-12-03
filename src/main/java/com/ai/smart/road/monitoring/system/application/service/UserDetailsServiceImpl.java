package com.ai.smart.road.monitoring.system.application.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User.UserBuilder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.ai.smart.road.monitoring.system.application.model.Role;
import com.ai.smart.road.monitoring.system.application.model.User;
import com.ai.smart.road.monitoring.system.application.repository.UserRepository;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	private final UserRepository userRepository;

	@Autowired
	public UserDetailsServiceImpl(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		// Fetch user from DB
		User appUser = userRepository.findByUsername(username)
				.orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));

		// Default role (if null)
		String roleName = "USER";

		Role role = appUser.getRole();
		if (role != null && role.getName() != null) {
			roleName = role.getName(); // ADMIN, MUNICIPAL, COLLECTOR, etc.
		}

		// Build UserDetails object for Spring Security
		UserBuilder builder = org.springframework.security.core.userdetails.User.withUsername(appUser.getUsername());

		builder.password(appUser.getPassword()); // stored BCrypt hash
		builder.roles(roleName); // Spring auto-adds "ROLE_"
		builder.disabled(!appUser.isEnabled()); // boolean enabled flag

		return builder.build();
	}
}
