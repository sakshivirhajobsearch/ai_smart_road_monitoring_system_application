package com.ai.smart.road.monitoring.system.application.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.ai.smart.road.monitoring.system.application.model.User;
import com.ai.smart.road.monitoring.system.application.repository.UserRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {

	private final UserRepository userRepository;

	public CustomUserDetailsService(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userRepository.findByUsername(username)
				.orElseThrow(() -> new UsernameNotFoundException("User not found"));

		return org.springframework.security.core.userdetails.User.builder().username(user.getUsername())
				.password(user.getPassword()) // bcrypt hashed
				.roles(user.getRole()) // String role
				.disabled(!user.isEnabled()).build();
	}
}
