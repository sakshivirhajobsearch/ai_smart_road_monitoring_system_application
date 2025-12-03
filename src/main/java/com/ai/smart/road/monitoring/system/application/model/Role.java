package com.ai.smart.road.monitoring.system.application.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "role")
public class Role {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(nullable = false, unique = true)
	private String name; // ADMIN, COLLECTOR, MUNICIPAL, PWD, USER

	public Role() {
	}

	public Role(String name) {
		this.name = name;
	}

	// getters/setters
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
