package com.ai.smart.road.monitoring.system.application.config;

import java.net.URI;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;

@Configuration
public class AwsConfig {

	// AWS credentials and region
	@Value("${aws.accessKeyId}")
	private String accessKey;

	@Value("${aws.secretAccessKey}")
	private String secretKey;

	@Value("${aws.region}")
	private String region;

	// Optional: custom S3 endpoint (for localstack or custom endpoint)
	@Value("${aws.s3.endpoint:}")
	private String s3Endpoint;

	@Bean
	public S3Client s3Client() {
		// Create builder for S3Client
		var builder = S3Client.builder().region(Region.of(region)).credentialsProvider(
				StaticCredentialsProvider.create(AwsBasicCredentials.create(accessKey, secretKey)));

		// Optional endpoint override (e.g., localstack)
		if (s3Endpoint != null && !s3Endpoint.isEmpty()) {
			builder.endpointOverride(URI.create(s3Endpoint));
		}

		// Build and return the S3Client
		return builder.build();
	}
}
