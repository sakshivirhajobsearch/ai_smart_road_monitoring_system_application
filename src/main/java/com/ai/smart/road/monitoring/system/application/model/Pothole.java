package com.ai.smart.road.monitoring.system.application.model;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "pothole")
public class Pothole {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private Long roadId; // corresponds to setRoadId
	private String gpsLocation; // corresponds to setGpsLocation / getGpsLocation
	private double latitude; // corresponds to setLatitude / getLatitude
	private double longitude; // corresponds to setLongitude / getLongitude
	private double length;
	private double width;
	private double depth;
	private String severity; // corresponds to setSeverity / getSeverity
	private LocalDateTime detectedDate; // corresponds to setDetectedDate / getDetectedDate
	private LocalDateTime detectedAt; // corresponds to setDetectedAt / getDetectedAt
	private String imagePath; // corresponds to setImagePath / getImagePath
	private String status;

	// Optional alias for gpsLocation if needed
	private String gpsPin; // corresponds to getGpsPin / setGpsPin

	// Getters and Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getRoadId() {
		return roadId;
	}

	public void setRoadId(Long roadId) {
		this.roadId = roadId;
	}

	public String getGpsLocation() {
		return gpsLocation;
	}

	public void setGpsLocation(String gpsLocation) {
		this.gpsLocation = gpsLocation;
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

	public String getSeverity() {
		return severity;
	}

	public void setSeverity(String severity) {
		this.severity = severity;
	}

	public LocalDateTime getDetectedDate() {
		return detectedDate;
	}

	public void setDetectedDate(LocalDateTime detectedDate) {
		this.detectedDate = detectedDate;
	}

	public LocalDateTime getDetectedAt() {
		return detectedAt;
	}

	public void setDetectedAt(LocalDateTime detectedAt) {
		this.detectedAt = detectedAt;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getGpsPin() {
		return gpsPin;
	}

	public void setGpsPin(String gpsPin) {
		this.gpsPin = gpsPin;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
