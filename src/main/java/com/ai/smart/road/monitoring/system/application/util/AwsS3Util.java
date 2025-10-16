package com.ai.smart.road.monitoring.system.application.util;

import java.io.File;

import org.springframework.stereotype.Component;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;

@Component
public class AwsS3Util {

	private final AmazonS3 s3Client;

	public AwsS3Util() {
		String accessKey = "<YOUR_ACCESS_KEY>";
		String secretKey = "<YOUR_SECRET_KEY>";

		s3Client = AmazonS3ClientBuilder.standard().withRegion(Regions.AP_SOUTH_1)
				.withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
				.build();
	}

	public void uploadFile(String bucketName, String keyName, File file) {
		PutObjectRequest request = new PutObjectRequest(bucketName, keyName, file)
				.withCannedAcl(CannedAccessControlList.PublicRead);
		s3Client.putObject(request);
	}
}
