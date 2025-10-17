package com.ai.smart.road.monitoring.system.application.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ai.smart.road.monitoring.system.application.model.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	Optional<User> findByUsername(String username);
}
