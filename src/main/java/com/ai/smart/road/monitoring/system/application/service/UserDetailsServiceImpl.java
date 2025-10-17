package com.ai.smart.road.monitoring.system.application.service;

import java.util.Collections;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.ai.smart.road.monitoring.system.application.model.User;
import com.ai.smart.road.monitoring.system.application.repository.UserRepository;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	private final UserRepository userRepository;

	public UserDetailsServiceImpl(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userRepository.findByUsername(username)
				.orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));

		SimpleGrantedAuthority authority = new SimpleGrantedAuthority("ROLE_" + user.getRole());

		return org.springframework.security.core.userdetails.User.builder().username(user.getUsername())
				.password(user.getPassword()) // plain text
				.authorities(Collections.singletonList(authority)).disabled(!user.isEnabled()).build();
	}
}
