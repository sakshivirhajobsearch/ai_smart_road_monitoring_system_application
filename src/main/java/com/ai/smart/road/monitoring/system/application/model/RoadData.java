package com.ai.smart.road.monitoring.system.application.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "road_data")
public class RoadData {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String roadName;
	private double latitude;
	private double longitude;
	private double surfaceLevel;
	private double slope;
	private String status;
	private String sensorFile;

	// Getters and setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getRoadName() {
		return roadName;
	}

	public void setRoadName(String roadName) {
		this.roadName = roadName;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public double getSurfaceLevel() {
		return surfaceLevel;
	}

	public void setSurfaceLevel(double surfaceLevel) {
		this.surfaceLevel = surfaceLevel;
	}

	public double getSlope() {
		return slope;
	}

	public void setSlope(double slope) {
		this.slope = slope;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSensorFile() {
		return sensorFile;
	}

	public void setSensorFile(String sensorFile) {
		this.sensorFile = sensorFile;
	}
}
