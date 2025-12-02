package com.ai.smart.road.monitoring.system.application.service;

import java.util.List;

import org.springframework.context.annotation.Primary;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.ai.smart.road.monitoring.system.application.model.User;
import com.ai.smart.road.monitoring.system.application.repository.UserRepository;

@Primary
@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	private final UserRepository repo;

	public UserDetailsServiceImpl(UserRepository repo) {
		this.repo = repo;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		User user = repo.findByUsername(username);

		if (user == null) {
			throw new UsernameNotFoundException("User not found: " + username);
		}

		List<SimpleGrantedAuthority> roles = List.of(new SimpleGrantedAuthority("ROLE_" + user.getRole()));

		return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), roles);
	}
}
