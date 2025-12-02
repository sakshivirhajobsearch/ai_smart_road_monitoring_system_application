package com.ai.smart.road.monitoring.system.application.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.ai.smart.road.monitoring.system.application.model.User;
import com.ai.smart.road.monitoring.system.application.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

	private final UserRepository userRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		User user = userRepository.findByUsername(username);

		if (user == null) {
			throw new UsernameNotFoundException("Invalid username: " + username);
		}

		// Since role is a STRING (ADMIN, PWD, etc.)
		String roleName = user.getRole(); // <-- FIXED (no .getName())

		return org.springframework.security.core.userdetails.User.withUsername(user.getUsername())
				.password(user.getPassword()).roles(roleName) // Spring auto adds "ROLE_"
				.build();
	}
}
