package com.ai.smart.road.monitoring.system.application.dto;

import java.time.LocalDateTime;

public class PotholeResponse {

	private Long id;
	private double length;
	private double width;
	private double depth;
	private double x;
	private double y;
	private String gpsLocation;
	private LocalDateTime detectedAt;

	// Default constructor
	public PotholeResponse() {
	}

	// Constructor with gpsLocation parsing to x and y
	public PotholeResponse(Long id, double length, double width, double depth, String gpsLocation,
			LocalDateTime detectedAt) {
		this.id = id;
		this.length = length;
		this.width = width;
		this.depth = depth;
		this.gpsLocation = gpsLocation;
		this.detectedAt = detectedAt;

		// Derive x and y from gpsLocation if present
		if (gpsLocation != null && gpsLocation.contains(",")) {
			try {
				String[] parts = gpsLocation.split(",");
				this.x = Double.parseDouble(parts[0].trim());
				this.y = Double.parseDouble(parts[1].trim());
			} catch (NumberFormatException e) {
				this.x = 0;
				this.y = 0;
			}
		} else {
			this.x = 0;
			this.y = 0;
		}
	}

	// Full constructor with explicit x and y
	public PotholeResponse(Long id, double length, double width, double depth, double x, double y, String gpsLocation,
			LocalDateTime detectedAt) {
		this.id = id;
		this.length = length;
		this.width = width;
		this.depth = depth;
		this.x = x;
		this.y = y;
		this.gpsLocation = gpsLocation;
		this.detectedAt = detectedAt;
	}

	// Getters and Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
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

	public double getDepth() {
		return depth;
	}

	public void setDepth(double depth) {
		this.depth = depth;
	}

	public double getX() {
		return x;
	}

	public void setX(double x) {
		this.x = x;
	}

	public double getY() {
		return y;
	}

	public void setY(double y) {
		this.y = y;
	}

	public String getGpsLocation() {
		return gpsLocation;
	}

	public void setGpsLocation(String gpsLocation) {
		this.gpsLocation = gpsLocation;
	}

	public LocalDateTime getDetectedAt() {
		return detectedAt;
	}

	public void setDetectedAt(LocalDateTime detectedAt) {
		this.detectedAt = detectedAt;
	}

}
