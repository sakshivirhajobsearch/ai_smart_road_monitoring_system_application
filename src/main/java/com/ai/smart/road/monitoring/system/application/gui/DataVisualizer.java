package com.ai.smart.road.monitoring.system.application.gui;

import java.io.File;
import java.util.Collections;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class DataVisualizer {

	private static final ObjectMapper mapper = new ObjectMapper();

	@JsonIgnoreProperties(ignoreUnknown = true)
	public static class Road {
		public String location;
		public String condition;
		public String analyzed_at;
	}

	@JsonIgnoreProperties(ignoreUnknown = true)
	public static class Pothole {
		public Double latitude;
		public Double longitude;
		public String severity;
		public String detected_at;
	}

	public static List<Road> loadRoads(String filePath) {
		try {
			return mapper.readValue(new File(filePath), new TypeReference<List<Road>>() {
			});
		} catch (Exception e) {
			System.out.println("❌ Error loading roads: " + e.getMessage());
			return Collections.emptyList();
		}
	}

	public static List<Pothole> loadPotholes(String filePath) {
		try {
			return mapper.readValue(new File(filePath), new TypeReference<List<Pothole>>() {
			});
		} catch (Exception e) {
			System.out.println("❌ Error loading potholes: " + e.getMessage());
			return Collections.emptyList();
		}
	}
}
