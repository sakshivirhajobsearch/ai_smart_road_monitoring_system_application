package com.ai.smart.road.monitoring.system.application.dto;

import java.io.Serializable;

/**
 * Simple DTO to hold dashboard statistics. Put it under:
 * com.ai.smart.road.monitoring.system.application.dto
 */
public class StatsDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private int totalPotholes;
	private int pendingRepairs;
	private int todayDetections;

	public StatsDTO() {
	}

	public StatsDTO(int totalPotholes, int pendingRepairs, int todayDetections) {
		this.totalPotholes = totalPotholes;
		this.pendingRepairs = pendingRepairs;
		this.todayDetections = todayDetections;
	}

	public int getTotalPotholes() {
		return totalPotholes;
	}

	public void setTotalPotholes(int totalPotholes) {
		this.totalPotholes = totalPotholes;
	}

	public int getPendingRepairs() {
		return pendingRepairs;
	}

	public void setPendingRepairs(int pendingRepairs) {
		this.pendingRepairs = pendingRepairs;
	}

	public int getTodayDetections() {
		return todayDetections;
	}

	public void setTodayDetections(int todayDetections) {
		this.todayDetections = todayDetections;
	}

	@Override
	public String toString() {
		return "StatsDTO{" + "totalPotholes=" + totalPotholes + ", pendingRepairs=" + pendingRepairs
				+ ", todayDetections=" + todayDetections + '}';
	}
}
