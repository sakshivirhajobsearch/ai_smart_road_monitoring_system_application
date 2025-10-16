package com.ai.smart.road.monitoring.system.application.dto;

import java.time.LocalDateTime;

public class RoadDataDTO {

	private String id;
	private double length;
	private double width;
	private double height;
	private LocalDateTime recordedAt;
	private String levelStatus; // optional

	// No-arg constructor
	public RoadDataDTO() {
	}

	// All-args constructor
	public RoadDataDTO(String id, double length, double width, double height, LocalDateTime recordedAt) {
		this.id = id;
		this.length = length;
		this.width = width;
		this.height = height;
		this.recordedAt = recordedAt;
	}

	// Getters & setters
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public double getLength() {
		return length;
	}

	public void setLength(double length) {
		this.length = length;
	}

	public double getWidth() {
		return width;
	}

	public void setWidth(double width) {
		this.width = width;
	}

	public double getHeight() {
		return height;
	}

	public void setHeight(double height) {
		this.height = height;
	}

	public LocalDateTime getRecordedAt() {
		return recordedAt;
	}

	public void setRecordedAt(LocalDateTime recordedAt) {
		this.recordedAt = recordedAt;
	}

	public String getLevelStatus() {
		return levelStatus;
	}

	public void setLevelStatus(String levelStatus) {
		this.levelStatus = levelStatus;
	}
}
