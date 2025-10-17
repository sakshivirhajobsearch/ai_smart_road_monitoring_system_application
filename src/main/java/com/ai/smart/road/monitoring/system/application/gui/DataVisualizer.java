package com.ai.smart.road.monitoring.system.application.gui;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

public class DataVisualizer {

	private final ObjectMapper objectMapper;

	public DataVisualizer() {
		this.objectMapper = new ObjectMapper();
		// ✅ Add Java 8 date/time support
		objectMapper.registerModule(new JavaTimeModule());
		objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
	}

	/**
	 * Loads JSON data from classpath or filesystem. Auto-generates valid files if
	 * missing or invalid.
	 */
	public <T> T loadJson(String fileName, TypeReference<T> typeRef) {
		try {
			File file = resolveFile(fileName);
			if (!file.exists()) {
				generateSampleJson(fileName);
			}

			try (InputStream inputStream = new FileInputStream(file)) {
				return objectMapper.readValue(inputStream, typeRef);
			}

		} catch (Exception e) {
			System.err.println("⚠️ Error loading JSON file: " + fileName);
			e.printStackTrace();

			// If invalid format, regenerate a clean file and try again once
			try {
				System.out.println("🔄 Regenerating invalid JSON file: " + fileName);
				generateSampleJson(fileName);
				File regenerated = resolveFile(fileName);
				try (InputStream inputStream = new FileInputStream(regenerated)) {
					return objectMapper.readValue(inputStream, typeRef);
				}
			} catch (Exception retry) {
				System.err.println("❌ Failed to reload after regeneration: " + fileName);
				retry.printStackTrace();
			}
			return null;
		}
	}

	/** Resolves JSON file path (classpath or working dir) */
	private File resolveFile(String fileName) {
		File file = new File(fileName);
		if (!file.exists()) {
			file = new File(System.getProperty("user.dir"), fileName);
		}
		return file;
	}

	/** Auto-generates example JSONs if missing or invalid */
	private void generateSampleJson(String fileName) {
		try {
			File file = resolveFile(fileName);
			file.getParentFile().mkdirs();

			String content;

			if (fileName.contains("road_data.json")) {
				content = """
						[
						  {
						    "id": 1,
						    "length": 5.2,
						    "width": 4.5,
						    "height": 0.1,
						    "latitude": 23.1765,
						    "longitude": 79.9343,
						    "recordedAt": "2025-10-17T10:00:00"
						  },
						  {
						    "id": 2,
						    "length": 3.8,
						    "width": 3.9,
						    "height": 0.2,
						    "latitude": 23.1812,
						    "longitude": 79.9398,
						    "recordedAt": "2025-10-17T11:00:00"
						  }
						]
						""";
			} else if (fileName.contains("potholes_data.json")) {
				content = """
						[
						  {
						    "id": 101,
						    "depth": 12.5,
						    "width": 30.0,
						    "length": 40.0,
						    "latitude": 23.1765,
						    "longitude": 79.9343,
						    "gpsLocation": "23.1765,79.9343",
						    "detectedAt": "2025-10-17T12:30:00"
						  },
						  {
						    "id": 102,
						    "depth": 8.3,
						    "width": 20.5,
						    "length": 25.0,
						    "latitude": 23.1812,
						    "longitude": 79.9398,
						    "gpsLocation": "23.1812,79.9398",
						    "detectedAt": "2025-10-17T13:00:00"
						  }
						]
						""";
			} else if (fileName.contains("dashboard_data.json")) {
				content = String.format("""
						{
						  "total_roads": 2,
						  "total_potholes": 2,
						  "last_updated": "%s"
						}
						""", LocalDateTime.now());
			} else {
				content = "{}";
			}

			try (FileWriter writer = new FileWriter(file)) {
				writer.write(content);
			}

			System.out.println("✅ Auto-generated valid JSON file: " + file.getAbsolutePath());

		} catch (Exception e) {
			System.err.println("⚠️ Failed to generate JSON file: " + fileName);
			e.printStackTrace();
		}
	}

	/** GUI placeholder methods */
	public void initializeWithData(List<?> roads, List<?> potholes, Map<String, Object> summary) {
		System.out.println(
				"Visualizer initialized with " + roads.size() + " roads and " + potholes.size() + " potholes.");
		System.out.println("Dashboard summary: " + (summary != null ? summary : "{}"));
	}

	public void showVisualizer() {
		System.out.println("Dashboard visualization ready!");
	}
}
